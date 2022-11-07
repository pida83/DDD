//
//  ListProductUseCase.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import Foundation


protocol ListProductUseCase {
    func execute(requestValue: ListProductUseCaseRequestValue, completion: @escaping (Result<ProductPage, Error>) -> Void )
}

class DefaultListProductUseCase : ListProductUseCase {
    private let productRepository: ProductRepository
    
    init(productRepository: ProductRepository) {
        self.productRepository = productRepository
    }
    
    func execute(requestValue: ListProductUseCaseRequestValue, completion: @escaping (Result<ProductPage, Error>) -> Void) {
        productRepository.fetchProductList(query: requestValue.query , page: requestValue.page) { result in
            completion(result)
        }
    }
    
}

struct ListProductUseCaseRequestValue {
    let page: Int
    let pageLimit: Int
    
    var query : [String: Any] {
        return ["startPage": page, "pageSize" : pageLimit]
    }
    
    init(page: Int, pageLimit: Int) {
        self.page      = page
        self.pageLimit = pageLimit
    }
}
