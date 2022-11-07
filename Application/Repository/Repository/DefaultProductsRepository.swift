//
//  DefaultProductsRepository.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import Foundation
import SwiftyJSON



class DefaultProductsRepository: ProductRepository {
    
    init(){
        
    }
    
    func fetchProductList(query: [String : Any], page : Int, completion: @escaping (Result<ProductPage, Error>) -> Void) {
        let provider = APIEndPoints.getProducts(with: .init(page: page))
        
            provider.request(.list(query), completion: { result in
                switch result {
                case .success(let list):
                    let data  = JSON(list.data)
                        
                    completion(.success(data.toPruductsDomain()))
                case .failure(let err):
                    dump(err)
                }
            })
    }
}




extension JSON {
    func toPruductsDomain() -> ProductPage {
        print(self["parkingInfoList"].array?.count)
        var products: [Product] = []
        
        if let list = self["parkingInfoList"].array {
            products = list.map{ json in
                return Product(
                    id: json["parkingName"].string ?? "error",
                    comment: json["parkingName"].string ?? "error",
                    address: json["addrJibun"].string ?? "error",
                    releaseTime: json["workDate"].string ?? "error",
                    price: json["tel"].string ?? "error"
                )
            }
        }
        return ProductPage(page: self["startPage"].int ?? 0, totalPages: self["totalCount"].int ?? 0, list: products)
    }
}
