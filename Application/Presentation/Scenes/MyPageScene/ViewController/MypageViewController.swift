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

class MypageViewController: UIViewController {
    
    var viewModel: MypageViewModel!
    var layoutModel: MypageLayoutModel!
    var disposeBag: DisposeBag = .init()
    
    static func create(with viewModel: MypageViewModel) -> MypageViewController {
        let vc = MypageViewController()
            vc.viewModel = viewModel
            vc.layoutModel = .init()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(to: viewModel)
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
        layoutModel.action = MypageAction(cancelAction: self.cancelAction, confirmAction: self.confirmAction)
        
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
        
        // 피커뷰
        viewModel.output_didUpdateList.subscribe(onNext: {[weak self] _ in
            self?.layoutModel.coinPicker.reloadAllComponents()
        }).disposed(by: disposeBag)
        
        self.viewModel.output_name.subscribe (onNext:{ name in
            self.layoutModel.nameText.rx.text.onNext(name)
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addKeyboardNotifications()
        layoutModel.mainTable.delegate = self
        layoutModel.mainTable.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardNotifications()
    }
    
    /* ---------------------------------------------------
     * Keyboard 노출 감지하는 NotificationCenter Observer 추가
     * ---------------------------------------------------- */
    func addKeyboardNotifications(){
        // 키보드가 나타날 때 앱에 알리고 keyboardWillShow() 메소드를 실행하는 Observer를 추가한다.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에 알리고 keyboardWillHide() 메소드를 실행하는 Observer를 추가한다.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }

    /* ---------------------------------------------------
     * Keyboard 노출 감지하는 NotificationCenter Observer 제거
     * ---------------------------------------------------- */
    func removeKeyboardNotifications(){
        // 키보드가 나타날 때 앱에게 알리는 Observer를 제거한다.
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification , object: nil)
        // 키보드가 사라질 때 앱에게 알리는 Observer를 제거한다.
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 키보드가 나타나는 UIResponder.keyboardWillShowNotification 알림 수신
    @objc func keyboardWillShow(_ noti: NSNotification){
        // 키보드의 높이만큼 웹뷰 영역을 올려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight  = keyboardRectangle.height
//            self.layoutModel.mainTable.transform = .init(translationX: 0, y: -(keyboardHeight - 50))
            self.layoutModel.inputView.transform = .init(translationX: 0, y: -(keyboardHeight - 50))
            self.layoutModel.confirm.transform = .init(translationX: 0, y: -(keyboardHeight - 50))
            self.layoutModel.cancel.transform = .init(translationX: 0, y: -(keyboardHeight - 50))
            
//            self.webViewMain.frame.origin.y -= (keyboardHeight - 50)    // 툴바높이 50 제외
        }
    }
    // 키보드가 사라지는 UIResponder.keyboardWillHideNotification 알림 수신
    @objc func keyboardWillHide(_ noti: NSNotification){
        // 키보드의 높이만큼 웹뷰 영역을 내려준다.
        if let keyboardFrame: NSValue = noti.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight  = keyboardRectangle.height
            self.layoutModel.inputView.transform = .identity
            self.layoutModel.confirm.transform = .identity
            self.layoutModel.cancel.transform = .identity
        }
    }
    
    func cancelAction(){
        self.view.endEditing(true)
        self.viewModel.didTapDisconnect()
    }
    
    func confirmAction() {
        if self.layoutModel.inputView.hasText,  let name = self.layoutModel.inputView.text {
            self.viewModel.didInputSelected(name: name)
        }
        self.cancelAction()
    }
}

extension MypageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("test \(viewModel.data.count)")
        return viewModel.data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MypageTableCell.identifier) as? MypageTableCell else { return UITableViewCell() }
        
        let data    =  viewModel.data[indexPath.row]
        
        cell.setData(data: data, name: viewModel.selected)
        return cell
    }
}

extension MypageViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        let cellHeight = tableView.frame.height / layoutModel.TABLE_ROW_PER_PAGE

        return UITableView.automaticDimension
    }
    
}


extension MypageViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.lists.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.lists[row]
    }
       
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(viewModel.lists[row])
        self.viewModel.didInputSelected(name: viewModel.lists[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
    
}
    
