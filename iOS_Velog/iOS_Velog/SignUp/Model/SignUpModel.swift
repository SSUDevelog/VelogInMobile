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
    let name:String
    let id:String
    let password:String
    let role:String
    
}

// MARK: - SignupResponse
struct SignupResponse: Codable {
    let code:Int
    let msg:String
    let success:Bool
}
