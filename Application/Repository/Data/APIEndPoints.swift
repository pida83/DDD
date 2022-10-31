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

public struct APIEndPoints {
    static func getProducts(with: ProductsRequstDTO) -> MoyaProvider<APIEndPointService>{
        let provider = MoyaProvider<APIEndPointService>()
        return provider
    }

}

public enum APIEndPointService {
    case list([String : Any])
}

extension APIEndPointService: TargetType {
    public var baseURL: URL {
//        return URL(string: "http://211.252.37.224/rest")!
         return URL(string: "http://localhost:3000")!
    
    }
    public var path: String {
        switch self {
            case .list: return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .list : return .post
        }
    }

    // 4
    public var sampleData: Data {
      return Data()
    }

    // 5
      public var task: Task {
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
      public var headers: [String: String]? {
          return ["Content-Type": "application/json"]
      }

      // 7
      public var validationType: ValidationType {
          return .successCodes
      }

}
