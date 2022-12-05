//
//  DeleteTag.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/05.
//

import Foundation

struct DeleteTag: Codable{
    var tag: String
    init(_ tag:String){
        self.tag = tag
    }
}
