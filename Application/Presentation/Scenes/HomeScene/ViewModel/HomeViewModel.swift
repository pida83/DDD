//
//  HomeViewModel.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright (c) 2022 All rights reserved.
//

import RxSwift
import RxCocoa
import RxGesture


protocol HomeViewModelInput {
    func viewDidLoad()
}

protocol HomeViewModelOutput {
    var data : [Product] {get}
    var didItemLoaded: PublishSubject<Void> { get }
//    var weatherLoded: PublishSubject<Void> { get }
//    var didBookmarkSelected: PublishSubject<Void> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput { }

class DefaultHomeViewModel: HomeViewModel {
    
    var data: [Product] = [] {
        didSet {
            print("load")
            self.didItemLoaded.onNext(())
        }
    }
    var didItemLoaded: PublishSubject<Void> = .init()
    var useCase: ListProductUseCase
    
    // MARK: - OUTPUT
    init(useCase: ListProductUseCase){
        self.useCase = useCase
    }
}

// MARK: - INPUT. View event methods
extension DefaultHomeViewModel {
    func viewDidLoad() {
        
        useCase.execute(requestValue: ListProductUseCaseRequestValue(page: 3, pageLimit: 10) , completion: { result in
            switch result {
            case .success(let page) :
                self.data.append(contentsOf: page.list)
            case .failure(let err):
                print(err)
            }
        })
    }
}
