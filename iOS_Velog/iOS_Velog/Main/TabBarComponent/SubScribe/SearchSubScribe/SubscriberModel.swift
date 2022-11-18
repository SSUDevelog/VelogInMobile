//
//  SubscriberModel.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/15.
//

import Foundation


struct SubscriberModel: Codable{
    let name: String
}

struct AddSubscriberResponse: Codable{

    let profilePictureURL: String?
    let profileURL: String?
    let userName: String
    let validate: Bool
}

//"validate": true,
//"userName": "city7310",
//"profilePictureURL": "",
//"profileURL": "https://velog.io/@city7310"
