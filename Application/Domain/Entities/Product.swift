//
//  Product.swift
//  CloneProject
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import Foundation

public struct Product : Codable , Equatable, Identifiable {
    public typealias Identifier = String
    
    public let id : Identifier
    public let comment: String
    public let address: String
    public let releaseTime: String
    public let price : String
    
    public init(id: Identifier, comment: String, address: String, releaseTime: String, price: String) {
        self.id = id
        self.comment = comment
        self.address = address
        self.releaseTime = releaseTime
        self.price = price
    }
}


public struct ProductPage : Equatable{
    public let page: Int
    public let totalPages: Int
    public let list : [Product]
    
    public init(page: Int, totalPages: Int, list: [Product]) {
        self.page       = page
        self.totalPages = totalPages
        self.list   = list
    }
}
