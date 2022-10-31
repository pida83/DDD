//
//  MypageLayoutModel.swift
//  SharedTests
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import Then
import SnapKit

public struct MypageLayoutModel {
    
    var parentView: UIView = UIView(frame: .zero).then{
        $0.backgroundColor = CloneProjectAsset.defaultColor.color
    }
    
    var mainTable: UITableView = .init(frame: .zero).then{
        $0.backgroundColor = .black
        $0.register(MypageTableCell.self, forCellReuseIdentifier: MypageTableCell.identifier)
    }
    
    var textField: UITextField = .init(frame: .zero).then{
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let TABLE_ROW_PER_PAGE : CGFloat = 5
    
    public init() {
        
    }
    
    
    func viewDidLoad(parent: UIView) {
        setLayout(parent: parent)
        setConstraint(parent: parent)
        
    }
    

    func setLayout(parent: UIView) {
        parent.addSubview(parentView)
        parentView.addSubview(self.mainTable)
        parentView.addSubview(self.textField)
    }
    
    func setTextFieldData(data: StreamModel) {
//        let paddedStr = str.padding(toLength: 20, withPad: " ", startingAt: 0)
        let sum       = "\(data.sum)".leftPadding(toLength: 5, withPad: "  ")
        let dps       = "\(data.dps)".leftPadding(toLength: 5, withPad: "  ")
        let average   = "\(data.average)".leftPadding(toLength: 5, withPad: "  ")
        let howStrong = "\(data.howStrong)".leftPadding(toLength: 5, withPad: "  ")
        let check     = "\(data.sum > data.average ? "+" : "")"
        
        self.textField.text = "ud : [\(sum)] dp : [\(dps)] av: [\(average)] [\(howStrong)] [\(check)]"
        
    }
    
    func setConstraint( parent : UIView) {
        parentView.snp.makeConstraints {
            $0.edges.equalTo(parent.safeAreaLayoutGuide)
        }
        
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(4)
        }
        
        mainTable.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom)
            $0.bottom.equalToSuperview()
        }
        
        
        
    }
}


