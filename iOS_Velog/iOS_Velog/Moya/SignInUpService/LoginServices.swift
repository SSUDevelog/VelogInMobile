//
//  APIService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation
import Moya



enum LoginServices {
    case exception
    case signUp(param: SignupRequest)
    case signIn(param: SignInRequest)
}

extension LoginServices: TargetType {
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
  
  var sampleData: Data {
    return "@@".data(using: .utf8)!
  }
  
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
