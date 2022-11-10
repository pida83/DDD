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
    var scrollToBottomAction : (()-> Void)
}

class MypageLayoutModel {
    
    
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
    
    var downBtn: UIView = .init(frame:.zero).then{
        $0.backgroundColor = .gray
        $0.frame = .init(x: 0, y: 0, width: 70, height: 40)
    }
    var downText: UILabel = .init(frame: .zero).then{
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.text = "밑으로"
        $0.isUserInteractionEnabled = false
        $0.textAlignment = .center
    }
    
    var confirmText: UILabel = .init(frame: .zero).then{
        $0.font = .boldSystemFont(ofSize: 15)
        $0.textColor = .white
        $0.backgroundColor = .clear
        $0.text = "확인"
        $0.isUserInteractionEnabled = false
        $0.textAlignment = .center
    }
    
    var cancelText: UILabel = .init(frame: .zero).then{
        $0.font = .boldSystemFont(ofSize: 15)
        $0.backgroundColor = .clear
        $0.textColor = .black
        $0.text = "취소"
        $0.isUserInteractionEnabled = false
        $0.textAlignment = .center
    }
    
    var nameText : UILabel = .init(frame: .zero).then{
        $0.font = .boldSystemFont(ofSize: 25)
        $0.backgroundColor = .clear
        $0.textColor = .white
        $0.text = "name"
        $0.sizeToFit()
        $0.isUserInteractionEnabled = false
        $0.textAlignment = .center
    }
    
    var cancel: UIView = .init(frame:.zero).then{
        $0.backgroundColor = .gray
        $0.frame = .init(x: 0, y: 0, width: 70, height: 40)
    }
    
    var coinPicker : UIPickerView = .init(frame: .zero)
    
    var textField: UITextField = .init(frame: .zero).then{
        $0.backgroundColor = .black
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    let TABLE_ROW_PER_PAGE : CGFloat = 5
    
    
    var action : MypageAction?
    
    init() {
        
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
//        parentView.addSubview(self.coinPicker)
        
        parentView.addSubview(self.inputView)
        parentView.addSubview(self.cancel)
        parentView.addSubview(self.confirm)
        parentView.addSubview(self.downBtn)
        
        confirm.addSubview(confirmText)
        cancel.addSubview(cancelText)
        downBtn.addSubview(downText)
        parentView.addSubview(self.nameText)
    }
    
    func setTextFieldData(data: StreamModel, name: String) {
        let sum       = "\(data.sum)".leftPadding(toLength: 5, withPad: "  ")
        let dps       = "\(data.dps)".leftPadding(toLength: 5, withPad: "  ")
        let average   = "\(data.average)".leftPadding(toLength: 5, withPad: "  ")
        let strength   = String(repeating: "*", count: data.strength).leftPadding(toLength: 5, withPad: "  ")
        
        let check     = "\(data.sum > data.average ? "+" : "")"
        let outputText = "ud : [\(sum)] dp : [\(dps)] av: [\(average)] [\(strength)] [\(check)]"
        
        self.textField.text = outputText
        
    }
    
    func setConstraint( parent : UIView) {
        parentView.snp.makeConstraints {
            $0.edges.equalTo(parent.safeAreaLayoutGuide)
        }
        
        
        textField.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().dividedBy(6)
        }
        
        mainTable.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.top.equalTo(textField.snp.bottom)
            $0.bottom.equalToSuperview().offset(-150)
        }
        
        cancel.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.left.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-100)
        }
        
        confirm.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.right.equalToSuperview().offset(-10)
            $0.bottom.equalToSuperview().offset(-100)
        }
        downBtn.snp.makeConstraints{
            $0.width.equalTo(70)
            $0.height.equalTo(40)
            $0.right.equalToSuperview().offset(-10)
            $0.top.equalTo(confirm.snp.bottom)
        }
        inputView.snp.makeConstraints{
            $0.width.equalToSuperview()
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview()
        }
        
        confirmText.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        cancelText.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        downText.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        nameText.snp.makeConstraints{
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
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
            .subscribe(onNext: {[weak self]  _ in
                // 약한참조 처리
                self?.action?.confirmAction()
                
            })
            .disposed(by: disposeBag)
        
        self.cancel.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self]  _ in
                // 약한참조 처리
                self?.action?.cancelAction()
            })
            .disposed(by: disposeBag)
        
        self.downBtn.rx.tapGesture()
            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
            .when(.recognized)
            .subscribe(onNext: { [weak self]  _ in
                // 약한참조 처리
                self?.action?.scrollToBottomAction()
            })
            .disposed(by: disposeBag)
        
    }
}


