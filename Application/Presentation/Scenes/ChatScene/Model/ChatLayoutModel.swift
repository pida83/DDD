//
//  ChatLayoutModel.swift
//  SharedTests
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import Then
import SnapKit

struct ChatLayoutModel {
    
    var parentView: UIView = UIView(frame: .zero).then{
        $0.backgroundColor = CloneProjectAsset.defaultColor.color
    }
    
    var mainTable: UITableView = .init(frame: .zero).then{
        $0.backgroundColor = .yellow
    }
    
    var sendBtn: UIButton = .init(frame: .zero).then{
        $0.setTitle("sendData", for: .normal)
    }
    
    init() {
        
    }
    
    
    func viewDidLoad(parent: UIView) {
        setDefault(parent: parent)
        
        self.setLayout()
        self.setConstraint()
    }
    
    func setDefault(parent: UIView) {
        
        parent.addSubview(parentView)    
        parentView.snp.makeConstraints{
            $0.edges.equalTo(parent.safeAreaLayoutGuide)
        }
    }

    func setLayout() {
        parentView.addSubview(sendBtn)
    }
    
    
    
    func setConstraint() {
        sendBtn.snp.makeConstraints{
            $0.width.equalTo(50)
            $0.height.equalTo(30)
            $0.center.equalToSuperview()
        }
        
    }
}

