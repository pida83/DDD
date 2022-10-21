//
//  HomeDIContainer.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/14.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit

public class HoodDIContainer: DIContainer {
    init() { }
    
//    // MARK: Repository

//
//    // MARK: Usecases

//
//    // MARK: ViewModel
    func makeHoodCoordinator(navigationController: UINavigationController) -> HoodCoordinator {
        .init(navigationController: navigationController, dependencies: self)
    }
    
    func makeViewModel() -> HoodViewModel {
        DefaultHoodViewModel()
    }
}

extension HoodDIContainer : HoodCoordinatorDependencies {
    public func makeHoodViewController() -> HoodViewController {
        let vc = HoodViewController.create(with: makeViewModel())
            vc.view.backgroundColor = .brown
        return vc
    }
    
    
}
