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
import RxSwift
import RxCocoa
import RxGesture

struct MypageAction {
    var cancelAction : (()-> Void)
    var confirmAction : (()-> Void)
    var restartAction : (()-> Void)
}

public class MypageLayoutModel {
    
    
    var disposeBag: DisposeBag = .init()
    
    var parentView: UIView = UIView(frame: .zero).then{
        $0.backgroundColor = CloneProjectAsset.defaultColor.color
    }
    
    var mainTable: UITableView = .init(frame: .zero).then{
        $0.backgroundColor = .black
        $0.register(MypageTableCell.self, forCellReuseIdentifier: MypageTableCell.identifier)
    }
    
    var inputView : UITextField = .init(frame: .zero).then{
        $0.text = "btc"
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    var confirm: UIView = .init(frame:.zero).then{
        $0.backgroundColor = .blue
        $0.frame = .init(x: 0, y: 0, width: 70, height: 40)
    }
    
    var restart: UIView = .init(frame:.zero).then{
        $0.backgroundColor = .white
        $0.frame = .init(x: 0, y: 0, width: 70, height: 40)
    }
    
    var cancel: UIView = .init(frame:.zero).then{
        $0.backgroundColor = .gray
        $0.frame = .init(x: 0, y: 0, width: 70, height: 40)
    }
    
    var coinPicker : UIPickerView = .init(frame: .zero)
    
    var textField: UITextField = .init(frame: .zero).then{
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.textAlignment = .left
    }
    
    let TABLE_ROW_PER_PAGE : CGFloat = 5
    
    
    var action : MypageAction!
    
    public init() {
        
    }
    
    
    func viewDidLoad(parent: UIView) {
        setLayout(parent: parent)
        setConstraint(parent: parent)
        bind()
    }
    

    func setLayout(parent: UIView) {
        parent.addSubview(parentView)
        parentView.addSubview(self.mainTable)
        parentView.addSubview(self.textField)
        parentView.addSubview(self.inputView)
        parentView.addSubview(self.cancel)
        parentView.addSubview(self.confirm)
        parentView.addSubview(self.restart)
    }
    
    func setTextFieldData(data: StreamModel, name: String = "btc") {
//        let paddedStr = str.padding(toLength: 20, withPad: " ", startingAt: 0)
        let sum       = "\(data.sum)".leftPadding(toLength: 5, withPad: " ")
        let dps       = "\(data.dps)".leftPadding(toLength: 5, withPad: " ")
        let average   = "\(data.average)".leftPadding(toLength: 5, withPad: " ")
        let howStrong = "\(data.howStrong)".leftPadding(toLength: 5, withPad: " ")
        let check     = "\(data.sum > data.average ? "+" : "")"
        
        self.textField.text = "[\(name)] d: [\(dps)] u: [\(sum)] a: [\(average)] [\(howStrong)]\(check) : \(data.lastPrice)"
        
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
        
        cancel.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.left.equalToSuperview().offset(50)
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        confirm.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.right.bottom.equalToSuperview().offset(-50)
        }
        
        restart.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        inputView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-100)
        }
//        coinPicker.snp.makeConstraints{
//            $0.width.bottom.equalToSuperview()
//            $0.height.equalTo(200)
//        }
    }
    
    func bind() {
        self.confirm.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { _ in
                // 약한참조 처리
                self.action.confirmAction()
                
            })
            .disposed(by: disposeBag)
        
        self.cancel.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: {  _ in
                // 약한참조 처리
                self.action.cancelAction()
            })
            .disposed(by: disposeBag)
        
        self.restart.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: {  _ in
                // 약한참조 처리
                self.action.restartAction()
            })
            .disposed(by: disposeBag)
        
    }
}


