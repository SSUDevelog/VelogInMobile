//
//  SigninRequest.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation

struct SignInRequest: Codable {
    var fcmToken:String
    var id: String
    var password: String
    
    init(_ fcmToken:String,_ id: String, _ password: String) {
        self.fcmToken = fcmToken
        self.id = id
        self.password = password
    }
}
