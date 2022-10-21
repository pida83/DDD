//
//  CommonTabbarController.swift
//  PresentationTests
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxGesture

public enum TabItem: Int {
    case home = 0, hood , around , chat , mypage = 4
    public var title : String {
        switch self {
        case .home:
            return "홈"
        case .hood:
            return "동네"
        case .chat:
            return "채팅"
        case .around:
            return "근처"
        case .mypage:
            return "마이페이지"
        }
    }
}
public class CustomTabbar: UITabBar {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    
    
    
}
public class CommonTabbarController: UITabBarController {
    
    let toolbar = CommonMenuBar(frame: .zero)
    
    let mainMenu = CommonMenu(frame: .zero).then{
        $0.isHidden = true
    }
    
    let topView = UIView(frame: .zero).then{
        $0.backgroundColor = CloneProjectAsset.defaultColor.color
    }
    
    
    
    let bottomLine = UIView(frame: .zero).then{
        $0.backgroundColor = .white.withAlphaComponent(0.3)
    }
    
    var disposeBag: DisposeBag = .init()
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(topView)
        
        self.view.addSubview(bottomLine)
        
        self.view.backgroundColor = .clear
        delegate = self
        
        bind()
        
        self.tabBar.tintColor       = .white
        self.tabBar.barTintColor    = .white
        self.tabBar.backgroundColor = CloneProjectAsset.defaultColor.color
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(SharedConst.shared.paddingBottom)
        print(SharedConst.shared.paddingTop)
        
        topView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.top.equalToSuperview()
            $0.height.equalTo(SharedConst.shared.paddingTop)
        }
        
        bottomLine.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.equalTo(0.5)
            $0.bottom.equalTo(self.tabBar.snp.top)
        }
//
    }
    
    func bind() {
//        toolbar.btn.rx.tapGesture()
//            .throttle(.microseconds(500), latest: false, scheduler: MainScheduler.instance)
//            .when(.recognized)
//            .subscribe(onNext: didTabBtn)
//            .disposed(by: disposeBag)
    }
    
    func didTabBtn(input: UITapGestureRecognizer) {
        
        self.selectedIndex = 2
        
        tabBarController(self, didSelect: self.selectedViewController!)
        
        let selected = TabItem(rawValue: self.selectedIndex)
        var tabBarHeight = self.tabBar.frame.size.height;
        print(tabBarHeight)
        

//        self.mainMenu.isHidden = !self.mainMenu.isHidden
    }
}

extension CommonTabbarController: UITabBarControllerDelegate {
    
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print(#function, item)
    }
    
    // 변경 전 뷰컨과 인덱
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let selected = TabItem(rawValue: tabBarController.selectedIndex)
        let navi = viewController as? UINavigationController
        print("Should select viewController:  \(navi?.topViewController) \(tabBarController.selectedIndex) \(selected?.title ?? "none")")
           return true
       }
    
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selected = TabItem(rawValue: tabBarController.selectedIndex)
        let navi = viewController as? UINavigationController
        print("did select viewController: \(navi?.topViewController) \(viewController) \(tabBarController.selectedIndex) \(selected?.title ?? "none")")
    }
    
}
