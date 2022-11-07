//
//  File1.swift
//  Service
//
//  Created by inforex_imac on 2022/10/13.
//  Copyright © 2022 Yeoboya. All rights reserved.
//


import UIKit

protocol ChatCoordinatorDependencies {
    func makeChatViewController() -> ChatViewController
}

class ChatCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = .init()
    var navigationController : UINavigationController
    var dependencies: ChatCoordinatorDependencies
    
    
    
    init(navigationController: UINavigationController, dependencies: ChatCoordinatorDependencies) {
        self.navigationController = navigationController
        self.dependencies         = dependencies
    }
    
    func start() {
        let chatVC = self.dependencies.makeChatViewController()
        self.navigationController.pushViewController(chatVC, animated: false)
    }
}
