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
    var path: String {
        switch self{
        case .addSubscriber:
            return "subscribe/addsubscriber"
        case .getSubscriber:
            return "subscribe/getsubscriber"
        }
    }
//http://34.125.230.85:8080/subscribe/addsubscriber?fcmToken=temporaryFCMToken&name=lhr4884
    
    var method: Moya.Method {
        switch self{
        case .addSubscriber:
            return .post
        case .getSubscriber:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .addSubscriber(param: let param):
//            return .requestJSONEncodable(param)   여기가 문제야!!!!
            return .requestParameters(parameters: ["fcmToken" : param.fcmToken,"name" : param.name], encoding: URLEncoding.queryString)
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
