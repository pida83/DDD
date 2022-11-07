//
//  File1.swift
//  Service
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit


protocol MypageCoordinatorDependencies {
    func makeMypageViewController() -> MypageViewController
}

class MypageCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = .init()
    var dependencies: MypageCoordinatorDependencies
    var navigationController : UINavigationController
    
    
    init(navigationController: UINavigationController, dependencies: MypageCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies         = dependencies
    }
    
    func start() {
        let mypageVC = dependencies.makeMypageViewController()
        navigationController.pushViewController(mypageVC, animated: false)
    }
    
}
