//
//  HomeDIContainer.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/14.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit


public class AroundDIContainer: DIContainer {
    init() { }
    
//    // MARK: Repository

//
//    // MARK: Usecases

//
//    // MARK: ViewModel
    func makeAroundCoordinater(navigationController: UINavigationController) -> AroundCoordinator{
        .init(navigationController: navigationController, dependencies: self)
    }
    
    func makeViewModel() -> AroundViewModel{
        return DefaultAroundViewModel()
    }
}

extension AroundDIContainer: AroundCoordinatorDependencies {
    public func makeAroundViewController() -> AroundViewController {
        let vc = AroundViewController.create(with: makeViewModel())
            vc.view.backgroundColor = .cyan
        return vc
    }
}
