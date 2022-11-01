//
//  MypageViewController.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import Alamofire
import RxSwift

public class MypageViewController: UIViewController {
    
    var viewModel: MypageViewModel!
    var layoutModel: MypageLayoutModel!
    var disposeBag: DisposeBag = .init()
    
    public static func create(with viewModel: MypageViewModel) -> MypageViewController {
        let vc = MypageViewController()
        vc.viewModel = viewModel
        vc.layoutModel = .init()
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
        layoutModel.action = MypageAction(cancelAction: self.cancelAction, confirmAction: self.confirmAction, restartAction: willEnter)
        print(layoutModel.action)
        //        layoutModel.coinPicker.delegate = self
        //        layoutModel.coinPicker.dataSource = self
    }
    
    func bind(to viewModel: MypageViewModel) {
        
        // 실시간 채널
        viewModel.outModel.subscribe(onNext: { data in
            self.layoutModel.setTextFieldData(data: data, name: viewModel.selected)
        }).disposed(by: disposeBag)
        
        
        // 테이블 채널 1초 딜레이
        viewModel.output_didUpdate.subscribe(onNext: {[weak self] _ in
            self?.layoutModel.mainTable.reloadData()
            self?.layoutModel.mainTable.scrollToBottom(animated: false)
        }).disposed(by: disposeBag)
        
        viewModel.output_didUpdateList.subscribe(onNext: {[weak self] _ in
            self?.layoutModel.coinPicker.reloadAllComponents()
        }).disposed(by: disposeBag)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        layoutModel.mainTable.delegate = self
        layoutModel.mainTable.dataSource = self
        print("willapear")
        addObservers()
        willEnter()
    }
    
    
    func addObservers() {
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(willDeactive), name: UIScene.willDeactivateNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(willDeactive), name: UIApplication.willResignActiveNotification, object: nil)
        }
        
        if #available(iOS 13.0, *) {
            NotificationCenter.default.addObserver(self, selector: #selector(willEnter), name: UIScene.willEnterForegroundNotification, object: nil)
        } else {
            NotificationCenter.default.addObserver(self, selector: #selector(willEnter), name: UIApplication.willEnterForegroundNotification, object: nil)
        }
        
        // call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    @objc func willDeactive(){
        print("will deactive")
        self.viewModel.isSocketConnected() ? viewModel.setDisconnect() : nil
    }
    
    @objc func willEnter() {
        print("will enter")
        !self.viewModel.isSocketConnected() ? viewModel.startConnect() : nil
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("::::::::::: will disapear")
        NotificationCenter.default.removeObserver(self)
        willDeactive()
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // if keyboard size is not available for some reason, dont do anything
            return
        }
        
        // move the root view up by the distance of keyboard height
        self.layoutModel.parentView.transform = .init(translationX: 0, y: -(keyboardSize.height + 50))
//        self.layoutModel.inputView.transform = .init(translationX: 0, y: -(keyboardSize.height + 50))
        
    }
    

   @objc func keyboardWillHide(notification: NSNotification) {
     // move back the root view origin to zero
       self.layoutModel.parentView.transform = .identity
//       self.layoutModel.inputView.transform = .identity
   }
       
//   override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//           self.view.endEditing(true)
//
//       }
    
    public func cancelAction(){
        self.view.endEditing(true)
        self.viewModel.setDisconnect()
    }
    
    public func confirmAction() {
        
        if self.layoutModel.inputView.hasText,  let name = self.layoutModel.inputView.text {
            self.viewModel.didInputSelected(name: name.lowercased())
        }
        
        self.cancelAction()
        
    }
}

extension MypageViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("test \(viewModel.data.count)")
        return viewModel.data.count
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MypageTableCell.identifier) as? MypageTableCell else { return UITableViewCell() }
        
        let data    =  viewModel.data[indexPath.row]
        let row        = indexPath.row
        let cellHeight = tableView.frame.height / layoutModel.TABLE_ROW_PER_PAGE
        
        cell.setData(data: data, name: viewModel.selected)
        return cell
    }
}

extension MypageViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let cellHeight = tableView.frame.height / layoutModel.TABLE_ROW_PER_PAGE

        return UITableView.automaticDimension
    }
    
}


extension MypageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.lists.count
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.lists[row]
    }
       
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(viewModel.lists[row])
        self.viewModel.didInputSelected(name: viewModel.lists[row])
    }
    
    public func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
}
    
