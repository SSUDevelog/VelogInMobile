//
//  SignUpModel.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation

// MARK: - SignupModel
struct SignupModel: Codable {
    let code: Int
    let msg: String
    let success: Bool
}

// MARK: - SignupResponse
struct SignupResponse: Codable {
    let id,name,password,role:String
}
