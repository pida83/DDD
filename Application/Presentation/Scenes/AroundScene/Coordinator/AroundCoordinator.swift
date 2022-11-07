//
//  File1.swift
//  Service
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//


import UIKit

protocol AroundCoordinatorDependencies {
    func makeAroundViewController() -> AroundViewController
}

class AroundCoordinator: Coordinator {
    
    var childCoordinator : [Coordinator] = .init()
    var navigationController : UINavigationController
    var dependencies : AroundCoordinatorDependencies
    
    init(navigationController: UINavigationController, dependencies: AroundCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies         = dependencies
    }
    
    func start() {
        let aroundVC = self.dependencies.makeAroundViewController()
        self.navigationController.pushViewController(aroundVC, animated: false)
    }
}
