//
//  SubscriberService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/15.
//

import Foundation
import Moya
import Realm
import RealmSwift

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

        
        let realm = RealmService()
        let accessToken = realm.getToken()
        switch self{
        default:
            return ["Content-Type": "application/json","X-AUTH-TOKEN":accessToken]
        }

    }
    
}
