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
    }
    
    func bind(to viewModel: MypageViewModel) {
        
        // 실시간 채널
        viewModel.outModel.subscribe(onNext: { data in
            self.layoutModel.setTextFieldData(data: data)
//            self.layoutModel.textField.text = "\(data.dps)"
//            print(data)
//            data.upCnt
//            data.downCnt
//            data.dps
//            data.sum
//            data.lastPrice
//            print(data.upCnt)
        }).disposed(by: disposeBag)
        
        
        // 테이블 채널 1초 딜레이
        viewModel.didUpdate.subscribe(onNext: {[weak self] _ in
            self?.layoutModel.mainTable.reloadData()
            self?.layoutModel.mainTable.scrollToBottom(animated: false)
        }).disposed(by: disposeBag)
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        layoutModel.mainTable.delegate = self
        layoutModel.mainTable.dataSource = self
        
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
        
        cell.setData(data: data, height: cellHeight)
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
