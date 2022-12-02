//
//  TagService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import Foundation
import Moya
import Realm
import RealmSwift
import UIKit

enum TagService{
    case addtag(param: AddTag)
    case gettag
    case tagpost
}

extension TagService: TargetType{
    
    var baseURL: URL {
        return URL(string: BaseURL.BURL)!
    }
    var path: String {
        switch self{
        case .addtag:
            return "tag/addtag"
        case .gettag:
            return "tag/gettag"
        case .tagpost:
            return "tag/tagpost"
        }
    }

    
    var method: Moya.Method {
        switch self{
        case .addtag:
            return .post
        case .gettag:
            return .get
        case .tagpost:
            return .get
        }
    }
    
    var task: Task {
        switch self{
        case .addtag(param: let param):
            return .requestParameters(parameters: ["tag" : param.tag], encoding: URLEncoding.queryString)
        case .gettag:
            return .requestPlain
        case .tagpost:
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
