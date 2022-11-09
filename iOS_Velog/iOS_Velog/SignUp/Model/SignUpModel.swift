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
//    let code:Int
//    let msg:String
//    let success:Bool
    let StatusCode: String
    let DataLength: String
}
