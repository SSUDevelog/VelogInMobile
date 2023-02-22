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
import UIKit

enum SubscriberService{
    case addSubscriber(param: AddRequest)
    case getSubscriber
    case checkSubscriber(_ name: String)
    case subscriberpost
    case unsubscribe(_ targetName: String)
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
        case .checkSubscriber(let name):
            return "subscribe/inputname/\(name)"
        case .subscriberpost:
            return "subscribe/subscriberpost"
        case .unsubscribe(let targetName):
            return "subscribe/unsubscribe/\(targetName)"
        }
    }

    
    var method: Moya.Method {
        switch self{
        case .addSubscriber:
            return .post
        case .getSubscriber:
            return .get
        case .checkSubscriber:
            return .get
        case .subscriberpost:
            return .get
        case .unsubscribe:
            return .delete
        }
    }
    
    var task: Task {
        switch self{
        case .addSubscriber(param: let param):
//            return .requestJSONEncodable(param)   여기가 문제야!!!!
            return .requestParameters(parameters: ["fcmToken" : param.fcmToken,"name" : param.name], encoding: URLEncoding.queryString)
        case .getSubscriber:
            return .requestPlain
        case .checkSubscriber:
            return .requestPlain
        case .subscriberpost:
            return .requestPlain
        case .unsubscribe:
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
