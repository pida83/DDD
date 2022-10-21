//
//  ProductRepository.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import Foundation


public protocol ProductRepository {
    func fetchProductList(query: [String : Any], page:Int, completion: @escaping (Result<ProductPage, Error>) -> Void)
}
