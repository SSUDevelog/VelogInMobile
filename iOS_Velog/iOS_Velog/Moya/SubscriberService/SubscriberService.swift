//
//  SubscriberService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/15.
//

import Foundation
import Moya

enum SubscriberService{
    case addSubscriber(param: AddRequest)
    case getSubscriber
}

extension SubscriberService: TargetType{
    var baseURL: URL {
        return URL(string: BaseURL.BURL)!
    }

    var path: String{
        switch self{
        case .addSubscriber(let param):
            return "subscribe/addsubscriber/@\(param.name)"
        case .getSubscriber:
            return "subscribe/getsubscrider"
        }
    }
    
    var method: Moya.Method {
        switch self{
        case .addSubscriber:
            return .get
        case .getSubscriber:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .addSubscriber:
            return .requestPlain
        case .getSubscriber:
            return .requestPlain
        }

    }
    
    var headers: [String : String]? {
        
        return [ "Content-type": "application/json", "X-AUTH-TOKEN" : "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJaeGN2YiIsInJvbGVzIjpbIlJPTEVfVVNFUiJdLCJpYXQiOjE2Njg0NDM3NTcsImV4cCI6MTY2ODQ0NzM1N30.k3JwblKYGTE9GPkinprT0klxB4j5jIp8cNK0YOSFpXc"]
        
    }
}
