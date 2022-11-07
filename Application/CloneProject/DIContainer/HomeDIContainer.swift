//
//  HomeDIContainer.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/14.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit

class HomeDIContainer: DIContainer {
    init() { }
    
//    // MARK: Repository

//
//    // MARK: Usecases

//
//    // MARK: ViewModel
    func makeHomeCoordinater(navigationController: UINavigationController) -> HomeCoordinator{
        .init(navigationController: navigationController, dependencies: self)
    }
    
    func makeUseCase() -> ListProductUseCase {
        
        return DefaultListProductUseCase(productRepository: DefaultProductsRepository())
    }
    func makeViewModel() -> HomeViewModel{
        return DefaultHomeViewModel(useCase: makeUseCase())
    }
}

extension HomeDIContainer: HomeCoordinatorDependencies {
    
    func makeHomeViewController() -> HomeViewController {
        let vc = HomeViewController.create(with: makeViewModel())
        return vc
    }
    
}
