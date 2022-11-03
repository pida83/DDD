//
//  File1.swift
//  Service
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit


 protocol HoodCoordinatorDependencies {
    func makeHoodViewController() -> HoodViewController
}
 class HoodCoordinator: Coordinator {
     var childCoordinator: [Coordinator] = .init()
    var navigationController : UINavigationController
    var dependencies: HoodCoordinatorDependencies
    
    
     init(navigationController: UINavigationController, dependencies: HoodCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies         = dependencies
    }
    
     func start() {
        let hoodVC = dependencies.makeHoodViewController()
            navigationController.pushViewController(hoodVC, animated: false)
    }
}
