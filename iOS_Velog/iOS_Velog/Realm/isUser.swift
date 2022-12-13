//
//  isUser.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/13.
//

import RealmSwift
import Realm
import Foundation

class isUser:Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var isuser:String = ""
    
    override static func primaryKey() -> String? {
      return "isUser"
    }
    
    convenience init(input:String){
        self.init()
        self.isuser = input
    }
}
