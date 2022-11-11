//
//  Token.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/11.
//

import RealmSwift
import Realm
import Foundation

class Token:Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var token:String = ""
    
    override static func primaryKey() -> String? {
      return "token"
    }
    
    convenience init(token:String){
        self.init()
        self.token = token
    }
}
