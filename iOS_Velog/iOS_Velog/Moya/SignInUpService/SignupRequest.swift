//
//  SignupRequest.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/06.
//

import Foundation

struct SignupRequest: Codable {
    var id: String
    var name: String
    var password: String
    var role: String
    
    init(_ id: String, _ name: String, _ password: String, _ role: String) {
        self.id = id
        self.name = name
        self.password = password
        self.role = role
    }
}
