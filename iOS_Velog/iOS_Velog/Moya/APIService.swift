//
//  APIService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation
import Moya

enum APIService{
    case exception
}

extension APIService: TargetType{
    var baseURL: URL {
        return URL(string: "http://34.125.230.85:8080/")!
    }
    
    var path: String {
        switch self{
        case .exception:
            return "/sign-api/exception"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .exception:
            return .get
        }
    }
    
    public var sampleData: Data {
      return Data()
    }
    
    var task: Task {
        switch self{
        case .exception:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self{
        case .exception:
            return nil
        }
    }
    
    
}
