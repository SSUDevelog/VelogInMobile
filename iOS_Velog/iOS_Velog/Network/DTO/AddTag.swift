//
//  tagString.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import Foundation

struct AddTag: Codable{
    var tag: String
    init(_ tag:String){
        self.tag = tag
    }
}
