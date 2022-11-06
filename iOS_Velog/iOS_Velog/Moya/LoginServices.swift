//
//  APIService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

//import Foundation
//import Moya
//import CloudKit
//
//enum LoginServices{
//    case exception
//    case signUp(_ id:String,_ name:String,_ password:String,_ role:String)
//}
//
//extension LoginServices: TargetType{
//    var baseURL: URL {
//        return URL(string: "http://34.125.230.85:8080/")!
//    }
//
//    var path: String {
//        switch self{
//        case .exception:
//            return "/sign-api/exception"
//        case .signUp:
//            return "/sign-api/sign-Up"
//        }
//    }
//
//    var method: Moya.Method {
//        switch self{
//        case .exception:
//            return .get
//        case .signUp:
//            return .post
//        }
//    }
//
//    var sampleData:Data{
//        switch self{
//        case .signUp(let id, let name, let password, let role):
//            let id = id
//            let name = name
//            let password = password
//            let role = role
//
//            return Data(
//                """
//                {
//                    "type": "success",
//                    "value": {
//                        "id": "\(id)",
//                        "name": "\(name)"
//                        "password":"\(password)"
//                        "role":"\(role)"
//                    }
//                }
//                """.utf8
//            )
//        case .exception: break
//        }
//    }
//
//    var task: Task {
//        switch self{
//        case .exception:
//            return .requestPlain
//        case .signUp(_):
//            return .requestData(sampleData)
//        }
//    }
//
//
//
//    var headers: [String : String]? {
//        switch self{
//        case .exception:
//            return nil
//        }
//    }
//
//
//}
import Foundation
import Moya



enum LoginServices {
    case exception
    case signUp(param: SignupRequest) // 에러의 주 원인
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
