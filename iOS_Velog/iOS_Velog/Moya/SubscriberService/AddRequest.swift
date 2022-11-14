//
//  AddRequest.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/15.
//

import Foundation

struct AddRequest: Codable{
    var name:String
    
    init(_ name:String){
        self.name = name
    }
}
