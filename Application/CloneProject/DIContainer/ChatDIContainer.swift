//
//  HomeDIContainer.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/14.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit



public class ChatDIContainer: DIContainer {
    init() { }
    
//    // MARK: Repository

//
//    // MARK: Usecases

//
//    // MARK: ViewModel
    
    
    func makeChatCoordinator(navigationController: UINavigationController) -> ChatCoordinator {
        .init(navigationController: navigationController, dependencies: self)
    }
    func makeViewModel() -> ChatViewModel{
        DefaultChatViewModel()
    }
}

extension ChatDIContainer: ChatCoordinatorDependencies {
    public func makeChatViewController() -> ChatViewController {
        let vc = ChatViewController.create(with: makeViewModel())
            vc.view.backgroundColor = .magenta
        return vc
    }
    
    
}
