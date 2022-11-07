//
//  File1.swift
//  Service
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDependencies {
    func makeHomeViewController() -> HomeViewController
}


class HomeCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = .init()
    var navigationController : UINavigationController
    var dependencies:  HomeCoordinatorDependencies
    
    
    init(navigationController: UINavigationController, dependencies:  HomeCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies         = dependencies
    }
    
    func start() {
        let homeVC = dependencies.makeHomeViewController()
        navigationController.pushViewController(homeVC, animated: false)
        
        
        // 네비게이션 컨트롤러는 탭바 컨트롤러에 접근 가능하다 캐스팅 해서 쓰던가 ...
        print(self.navigationController.tabBarController)
    }
    
    
}
