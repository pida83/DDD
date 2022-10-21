//
//  CommonMenuView.swift
//  UtilTests
//
//  Created by inforex_imac on 2022/10/17.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import SnapKit

public class CommonMenuBar: UIView {
    
    lazy var btn : UIButton = UIButton(type: .contactAdd).then{
        $0.setTitle("button", for: .normal)
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setLayout()
    }
    
    func setLayout(){
        addSubview(btn)
        
    }
    
    // #2
    public override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            print("::: disapear ")
        } else {
            print("::: apear \(newWindow?.safeAreaInsets.top)")
        }
    }

    // #3
    public override func willMove(toSuperview newSuperview: UIView?) {
    }
    
    // #4
    
    public override func didMoveToWindow() {
        self.backgroundColor = .yellow
        
        self.snp.makeConstraints {
            $0.height.equalTo(50)
            $0.left.right.equalToSuperview()
            $0.top.equalTo(SharedConst.shared.paddingTop)
        }
        
        
        btn.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.width.equalTo(50)
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
    
    
    // #6
    public override func didMoveToSuperview() {
        print("subview::didMoveToSuperview")
    }
}


