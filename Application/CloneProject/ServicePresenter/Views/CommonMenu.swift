//
//  CommonMenu.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/17.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import SnapKit



public class CommonMenu: UIView {    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func didMoveToWindow() {
        
        self.backgroundColor = .magenta
        
        self.snp.makeConstraints {
            $0.top.equalTo(SharedConst.shared.paddingTop)
            $0.bottom.equalTo(SharedConst.shared.paddingBottom)
            $0.left.equalToSuperview()
            $0.width.equalTo(SharedConst.shared.screenSize.width / 2)
        }
    }
}


