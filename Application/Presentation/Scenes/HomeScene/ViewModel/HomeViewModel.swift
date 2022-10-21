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


public protocol HomeViewModelInput {
    func viewDidLoad()
}

public protocol HomeViewModelOutput {
    var data : [Product] {get}
    var didItemLoaded: PublishSubject<Void> { get }
//    var weatherLoded: PublishSubject<Void> { get }
//    var didBookmarkSelected: PublishSubject<Void> { get }
}

public protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput { }

public class DefaultHomeViewModel: HomeViewModel {
    
    public var data: [Product] = [] {
        didSet {
            print("load")
            self.didItemLoaded.onNext(())
        }
    }
    public var didItemLoaded: PublishSubject<Void> = .init()
    var useCase: ListProductUseCase
    
    // MARK: - OUTPUT
    public init(useCase: ListProductUseCase){
        self.useCase = useCase
    }
}

// MARK: - INPUT. View event methods
extension DefaultHomeViewModel {
    public func viewDidLoad() {
        
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
