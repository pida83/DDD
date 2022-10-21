//
//  ListProductUseCase.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import Foundation


public protocol ListProductUseCase {
    func execute(requestValue: ListProductUseCaseRequestValue, completion: @escaping (Result<ProductPage, Error>) -> Void )
}

public class DefaultListProductUseCase : ListProductUseCase {
    private let productRepository: ProductRepository
    
    public init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    public func execute(requestValue: ListProductUseCaseRequestValue, completion: @escaping (Result<ProductPage, Error>) -> Void) {
        productRepository.fetchProductList(query: requestValue.query , page: requestValue.page) { result in
            completion(result)
        }
    }
    
}

public struct ListProductUseCaseRequestValue {
    public let page: Int
    public let pageLimit: Int
    
    public var query : [String: Any] {
        return ["startPage": page, "pageSize" : pageLimit]
    }
    
    public init(page: Int, pageLimit: Int) {
        self.page      = page
        self.pageLimit = pageLimit
    }
}
