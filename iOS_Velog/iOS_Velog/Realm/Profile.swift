//
//  Profile.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/13.
//

import RealmSwift
import Realm
import Foundation

class Profile:Object{
    @Persisted(primaryKey: true) var _id: ObjectId
    
    @Persisted var ID:String = ""
    @Persisted var PW:String = ""

    override static func primaryKey() -> String? {
      return "profile"
    }
    
    convenience init(ID:String,PW:String){
        self.init()
        self.ID = ID
        self.PW = PW
    }
}
