//
//  HomeDIContainer.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/14.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import UIKit


public class MypageDIContainer: DIContainer {
    init() { }
    
//    // MARK: Repository

//
//    // MARK: Usecases

//
//    // MARK: ViewModel

    
    func makeMypageCoordinator(navigationController: UINavigationController) -> MypageCoordinator{
        .init(navigationController: navigationController, dependencies: self)
    }
    
    func makeViewModel() -> MypageViewModel {
        DefaultMypageViewModel()
    }
}

extension MypageDIContainer: MypageCoordinatorDependencies {
    public func makeMypageViewController() -> MypageViewController {
        let vc = MypageViewController.create(with: makeViewModel())
            vc.view.backgroundColor = .darkGray
        return vc
    }
    
    
}
