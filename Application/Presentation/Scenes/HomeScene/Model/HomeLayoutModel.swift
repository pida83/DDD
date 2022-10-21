//
//  HomeLayoutModel.swift
//  SharedTests
//
//  Created by inforex_imac on 2022/10/17.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import Then
import SnapKit
import DropDown
import RxCocoa
import RxSwift
import RxGesture



public struct HomeLayoutModel {
    var disposeBag: DisposeBag = .init()
    
    var test: UIView = UIService.shared.getUIView()
    var parentView: UIView = UIService.shared.getUIView()
    var topSubView: UIView = UIService.shared.getUIView()
    var mainTable: UITableView = UIService.shared.getUITable().then{
        $0.backgroundColor = .clear
        $0.contentInset.top = 15
        $0.register(HomeTableCell.self, forCellReuseIdentifier: HomeTableCell.identifier)
    }
    
    var hoodLabel: UILabel = UILabel().then{
        $0.text = "치평동"
        $0.textColor = .white
    }
    
    var menuStackView: UIStackView =  UIService.shared.getUIStackView()
    
    let topLine = UIView(frame: .zero).then{
        $0.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    var searchButton : ImageContent = .init(image: UIImage(systemName: "magnifyingglass"))
    var extendButton : ImageContent = .init(image: UIImage(systemName: "text.bubble.rtl"))
    var alert        : ImageContent = .init(image: UIImage(systemName: "bell"))
    
    let TABLE_ROW_PER_PAGE : CGFloat = 5
    
    public init() {
        
    }
    
    func viewDidLoad(parent: UIView) {
        setLayout(parent: parent)
        setConstraint(parent: parent)
        bind()
    }
}

extension HomeLayoutModel {
    
    func setLayout(parent: UIView) {
        
        
        parent.addSubview(parentView)
        parentView.addSubview(mainTable)
        
        parentView.addSubview(topSubView)
        parentView.addSubview(topLine)
        topSubView.addSubview(menuStackView)
        topSubView.addSubview(hoodLabel)
        
        menuStackView.addArrangedSubview(searchButton)
        menuStackView.addArrangedSubview(extendButton)
        menuStackView.addArrangedSubview(alert)
        


    }
    
    func bind(){
        DropDown.appearance().textColor = UIColor.white
        DropDown.appearance().selectedTextColor = UIColor.red
        DropDown.appearance().textFont = UIFont.systemFont(ofSize: 14)
        DropDown.appearance().backgroundColor = CloneProjectAsset.defaultDark.color
        DropDown.appearance().selectionBackgroundColor = UIColor.lightGray
        DropDown.appearance().cellHeight = 40
        DropDown.appearance().cornerRadius = 10
        
        let dropDown = DropDown()
            dropDown.dataSource = ["풍암동", "치평동", "내동네"]
            dropDown.anchorView = self.hoodLabel
            dropDown.width = 150
        
//            dropDown.topOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
            dropDown.bottomOffset = CGPoint(x: 0, y: 50)
        

        hoodLabel.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { _ in
                // 약한참조 처리
                if dropDown.isHidden {
                    dropDown.show()
                } else {
                    dropDown.hide()
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setConstraint( parent : UIView) {
        
        parentView.snp.makeConstraints {
            $0.edges.equalTo(parent.safeAreaLayoutGuide)
        }
        
        topSubView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.equalTo(50)
            $0.top.equalTo(parent.safeAreaLayoutGuide)
        }
        
        mainTable.snp.makeConstraints{
            $0.top.equalTo(topSubView.snp.bottom)
            $0.left.right.equalToSuperview().inset(10)
            $0.bottom.equalTo(parent.safeAreaLayoutGuide)
        }
        
        menuStackView.snp.makeConstraints{
            $0.width.equalToSuperview().dividedBy(3.5)
            $0.height.equalToSuperview()
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
        
        topLine.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.top.equalTo(self.topSubView.snp.bottom)
        }
        
        hoodLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(10)
            $0.height.equalTo(50)
            $0.centerY.equalToSuperview()
        }
        
    }
    
}

