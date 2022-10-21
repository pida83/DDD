//
//  File1.swift
//  Service
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit


public protocol HoodCoordinatorDependencies {
    func makeHoodViewController() -> HoodViewController
}
public class HoodCoordinator: Coordinator {
    public var childCoordinator: [Coordinator] = .init()
    var navigationController : UINavigationController
    var dependencies: HoodCoordinatorDependencies
    
    
    public init(navigationController: UINavigationController, dependencies: HoodCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies         = dependencies
    }
    
    public func start() {
        let hoodVC = dependencies.makeHoodViewController()
            navigationController.pushViewController(hoodVC, animated: false)
    }
}
