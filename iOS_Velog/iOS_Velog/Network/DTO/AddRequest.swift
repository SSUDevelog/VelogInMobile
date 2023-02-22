//
//  AddRequest.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/15.
//

import Foundation

struct AddRequest: Codable{
    var fcmToken:String
    var name:String
    init(_ fcmToken:String,_ name:String){
        self.fcmToken = fcmToken
        self.name = name
    }
}
