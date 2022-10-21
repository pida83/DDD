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
        return URL(string: "http://211.252.37.224/rest")!
    }
    public var path: String {
        switch self {
            case .list: return "/parking"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .list : return .get
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
              return .requestParameters(parameters: param, encoding: URLEncoding.queryString)
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
