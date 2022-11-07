//
//  Product.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import Foundation
import SwiftProtobuf

struct Product : Codable , Equatable, Identifiable {
    typealias Identifier = String
    
    let id : Identifier
    let comment: String
    let address: String
    let releaseTime: String
    let price : String
    
    init(id: Identifier, comment: String, address: String, releaseTime: String, price: String) {
        self.id = id
        self.comment = comment
        self.address = address
        self.releaseTime = releaseTime
        self.price = price
    }
}


struct ProductPage : Equatable{
    let page: Int
    let totalPages: Int
    let list : [Product]
    
    init(page: Int, totalPages: Int, list: [Product]) {
        self.page       = page
        self.totalPages = totalPages
        self.list   = list
    }
}
