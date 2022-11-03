//
//  HoodLayoutModel.swift
//  SharedTests
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//


import UIKit
import Then
import SnapKit
import Charts
import RxGesture
import RxSwift
import RxCocoa

struct HoodLayoutModelAction {
    var didConnect: () -> Void
}

class HoodLayoutModel {
    
    var actions: HoodLayoutModelAction?
    
    var disposeBag: DisposeBag = .init()
    
    var parentView: UIView = UIView(frame: .zero).then{
        $0.backgroundColor = CloneProjectAsset.defaultColor.color
    }
     
    var chartView : HorizontalBarChartView = .init(frame: .zero).then{
        $0.drawBarShadowEnabled     = false
        $0.drawValueAboveBarEnabled = true
    }
    
    var connectLabel = UILabel().then{
        $0.textAlignment = .center
        $0.text = "start"
        $0.textColor = .white
        $0.sizeToFit()
    }
    
    var connectBtn: UIView = UIService.shared.getUIView().then{
        $0.backgroundColor = .blue
//        $0.frame = .init(x: 0, y: 0, width: 70, height: 40)
    }
    
    var mainTable: UITableView = .init(frame: .zero).then{
        $0.backgroundColor = .black
        $0.register(MypageTableCell.self, forCellReuseIdentifier: MypageTableCell.identifier)
    }
    
    init(actions: HoodLayoutModelAction?) {
        bind(to: actions)
    }
    
    
    func viewDidLoad(parent: UIView) {
        parent.addSubview(parentView)
        
        self.setLayout(parent: parent)
        setConstraint(parent: parent)
//        bind(to: actions)
    }
    
    func bind(to: HoodLayoutModelAction?) {
        self.connectBtn.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: {_ in
                // 약한참조 처리
                to?.didConnect()
                
            })
            .disposed(by: disposeBag)
    }
    

    func setLayout(parent: UIView) {
        parentView.addSubview(self.mainTable)
//        parentView.addSubview(self.chartView)
        
        parentView.addSubview(connectBtn)
        connectBtn.addSubview(connectLabel)
    }
    
    
    
    func setConstraint( parent : UIView) {
        parentView.snp.makeConstraints{
            $0.edges.equalTo(parent.safeAreaLayoutGuide)
        }
        
        mainTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
//        chartView.snp.makeConstraints{
//            $0.width.equalToSuperview()
//            $0.height.equalToSuperview().dividedBy(2)
//            $0.top.equalToSuperview()
//        }
        
        connectBtn.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        connectLabel.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
}


