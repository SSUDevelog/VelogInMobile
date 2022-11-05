//
//  Subscriber.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/05.
//

import RealmSwift
import Realm
import Foundation

class Subscriber:Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var velogId:String = ""
    
    override static func primaryKey() -> String? {
      return "velogId"
    }
    
    convenience init(velogId:String){
        self.init()
        self.velogId = velogId
    }
}

