//
//  SignIn.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation

// MARK: - SignInModel
struct SignInModel: Codable {
    let id,password:String
}

// MARK: - SignupResponse
struct SigninResponse: Codable {
    let code: Int
    let msg: String
    let success: Bool
    let token: String
}
