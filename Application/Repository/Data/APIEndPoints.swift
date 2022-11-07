//
//  APIEndPoints.swift
//  CloneProjectTests
//
//  Created by inforex_imac on 2022/10/18.
//  Copyright © 2022 Yeoboya. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON

struct APIEndPoints {
    static func getProducts(with: ProductsRequstDTO) -> MoyaProvider<APIEndPointService>{
        let provider = MoyaProvider<APIEndPointService>()
        return provider
    }

}

enum APIEndPointService {
    case list([String : Any])
}

extension APIEndPointService: TargetType {
    var baseURL: URL {
//        return URL(string: "http://211.252.37.224/rest")!
         return URL(string: "http://localhost:3000")!
    
    }
    var path: String {
        switch self {
            case .list: return ""
        }
    }

    var method: Moya.Method {
        switch self {
        case .list : return .post
        }
    }

    // 4
    var sampleData: Data {
      return Data()
    }

    // 5
      var task: Task {
          switch self {
          case .list(let param):
              
              var info = BookInfo()
              info.id = 1
              info.title = "test"
              info.author = "tat1"
              do {
                  let binaryData: Data = try info.serializedData()
                  print("sended")
                return .requestData(binaryData)
                  
              } catch let err {
                  print("error")
                  return .requestParameters(parameters: param, encoding: URLEncoding.httpBody)
              }
              


              
          }
          
      }

      // 6
      var headers: [String: String]? {
          return ["Content-Type": "application/json"]
      }

      // 7
      var validationType: ValidationType {
          return .successCodes
      }

}
