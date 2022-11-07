//
//  AroundLayoutModel.swift
//  SharedTests
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import Then
import SnapKit
import SpriteKit

struct AroundLayoutModel {
    
    var parentView: UIView = UIView(frame: .zero).then{
        $0.backgroundColor = CloneProjectAsset.defaultColor.color
    }
    
    var mainTable: UITableView = .init(frame: .zero).then{
        $0.backgroundColor = .yellow
    }
    
    var skView : SKView = .init(frame: .zero)
    
    init() {
        
    }
    
    
    func viewDidLoad(parent: UIView) {
        self.setLayout(parent: parent)
    }
    

    func setLayout(parent: UIView) {
        parent.addSubview(parentView)
        
        parentView.addSubview(skView)
        
        setConstraint(parent: parent)
    }
    
    
    
    func setConstraint( parent : UIView) {
        parentView.snp.makeConstraints{
            $0.edges.equalTo(parent.safeAreaLayoutGuide)
        }
        
        skView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
    }
}

