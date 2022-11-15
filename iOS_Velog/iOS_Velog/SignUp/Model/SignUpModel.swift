//
//  SignUpModel.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation

// MARK: - SignupModel
struct SignUpModel: Codable {
//    let code: Int
//    let msg: String
//    let success: Bool
    let id:String
    let name:String
    let password:String
    let role:String
    
}

// MARK: - SignupResponse
struct SignUpResponse: Codable {
    let code:Int
    let msg:String
    let success:Bool
    var token:String? = nil // 서버에서는 null로 던지는데 swift에서는 null 이 없어서 nil로 옵셔널 걸었다.

}
