//
//  APIService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation
import Moya



enum SignServices {
    case exception
    case signUp(param: SignUpRequest)
    case signIn(param: SignInRequest)
}

extension SignServices: TargetType {
  public var baseURL: URL {
      return URL(string: BaseURL.BURL)!
  }
  
  var path: String {
    switch self {
    case .exception:
        return "/sign-api/exception"
    case .signUp:
        return "/sign-api/sign-up"
    case .signIn:
        return "/sign-api/sign-in"
    }
  }
  
  var method: Moya.Method {
    switch self {
    case .exception:
        return .get
    case .signUp,
         .signIn:
      return .post
    }
  }
  
//  var sampleData: Data {
////    return "@@".data(using: .utf8)!
//      return Data()
//  }
//
//var sampleData: Data {
//    switch self {
//    case .signUp:
//        let user = SignUpModel(code: 0, msg: "aaa", success: tr)
//        if let data = try? JSONEncoder().encode(user) {
//            return data
//        } else {
//            return Data()
//        }
//    case .exception: return Data()
//
//    case .signIn(param: _): return Data()
//    }
//}

  
  var task: Task {
    switch self {
    case .exception:
        return .requestPlain
    case .signUp(let param):
        return .requestJSONEncodable(param)
    case .signIn(let param):
        return .requestJSONEncodable(param)
    }
  }

  var headers: [String: String]? {
    switch self {
    default:
      return ["Content-Type": "application/json"]
    }
  }
}
