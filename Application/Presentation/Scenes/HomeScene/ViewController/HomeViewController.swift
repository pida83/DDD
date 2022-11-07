//
//  HomeCViewController.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxGesture

class HomeViewController: UIViewController {
    
    var disposeBag: DisposeBag = .init()
    var viewModel: HomeViewModel!
    var layoutModel: HomeLayoutModel!
    
    static func create(with viewModel: HomeViewModel) -> HomeViewController {
        let vc = HomeViewController()
            vc.viewModel = viewModel
            vc.layoutModel = .init()
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
        layoutModel.viewDidLoad(parent: self.view)
        bind(to: viewModel)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        layoutModel.mainTable.delegate = self
        layoutModel.mainTable.dataSource = self
        print(#function, layoutModel.mainTable.frame.height)
    }
    
    func bind(to viewModel: HomeViewModel) {
        
        
        viewModel.didItemLoaded.subscribe(onNext: {
            print("reload")
            self.layoutModel.mainTable.reloadData()
            
        }).disposed(by: disposeBag)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("test \(viewModel.data.count)")
        return viewModel.data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.identifier) as? HomeTableCell else { return UITableViewCell() }
        
        let product    =  viewModel.data[indexPath.row]
        let row        = indexPath.row
        let cellHeight = tableView.frame.height / layoutModel.TABLE_ROW_PER_PAGE
        
        let data : HomeTableCell.CellDataType = (product, row, cellHeight)
            cell.setData(data: data)
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let cellHeight = tableView.frame.height / layoutModel.TABLE_ROW_PER_PAGE
            
        return UITableView.automaticDimension
    }
    
//    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        return nil
////        // 먼저 선택한 셀이 있다
////        if let row = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: row) {
////            UIView.animate(withDuration: 0.3 , delay: 0, animations: {
////                cell.transform = .identity
////            })
////
////            if row == indexPath {
////                return nil
////            }
////        }
////
////        return indexPath
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        guard let mapService = self.mapService else {
////            return
////        }
////
////        if let row = tableView.indexPathForSelectedRow, let cell = tableView.cellForRow(at: row) {
////            UIView.animate(withDuration: 0.3 , delay: 0, animations: {
////                cell.transform = .init(translationX: 20, y: 0)
////            })
////        }
////
////        self.viewModel.didSelectBookmark(indexPath: indexPath, completion: mapService.setLocation)
//    }
    
    
    
    
    
}
