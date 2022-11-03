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

struct HoodLayoutModel {
    
    var parentView: UIView = UIView(frame: .zero).then{
        $0.backgroundColor = CloneProjectAsset.defaultColor.color
    }
     
    var chartView : HorizontalBarChartView = .init(frame: .zero).then{
        $0.drawBarShadowEnabled     = false
        $0.drawValueAboveBarEnabled = true
    }
     
    
    var mainTable: UITableView = .init(frame: .zero).then{
        $0.backgroundColor = .black
        $0.register(MypageTableCell.self, forCellReuseIdentifier: MypageTableCell.identifier)
    }
    
     init() {
        
    }
    
    
    func viewDidLoad(parent: UIView) {
        parent.addSubview(parentView)
        
        self.setLayout(parent: parent)
        setConstraint(parent: parent)
    }
    

    func setLayout(parent: UIView) {
        parentView.addSubview(self.mainTable)
        parentView.addSubview(self.chartView)
     
        
    }
    
    
    
    func setConstraint( parent : UIView) {
        parentView.snp.makeConstraints{
            $0.edges.equalTo(parent.safeAreaLayoutGuide)
        }
        
        mainTable.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        chartView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(2)
            $0.top.equalToSuperview()
        }
        
        
    }
}


