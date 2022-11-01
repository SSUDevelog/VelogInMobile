//
//  SubscribeList.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/31.
//
//import RealmSwift
//import Foundation
//import UIKit
//import Network
//
//class SubscibeList: Object{
//
//
//    @Persisted var index: Int = 0
//    @Persisted var subscriberName: String = "hong"
//    @Persisted var isSubscribe: Bool = false
//    
//    override static func primaryKey() -> String? {
//        return "index"
//    }
//    
//    convenience init(index:Int,subscriberName:String,isSubscribe:Bool){
//        self.init()
//        self.index = index
//        self.subscriberName = subscriberName
//        self.isSubscribe = isSubscribe
//    }
//    
//    func createList(subscriberName: String,isSubscribe: Bool) {
//        var idx = 0
//        if let lastPerson = Instance.objects(SubscibeList.self).last {
//            idx = lastPerson.idx + 1
//        }
//
//        let list = SubscibeList()
//        list.index = idx
//        list.subscriberName = subscriberName
//        list.isSubscribe = isSubscribe
//        
//        try? Instance.write {
//            Instance.add(list)
//        }
//    }
//    
//}
