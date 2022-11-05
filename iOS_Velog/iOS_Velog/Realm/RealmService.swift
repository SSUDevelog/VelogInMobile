//
//  RealmService.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/05.
//

import Foundation
import RealmSwift
import Realm

class RealmService{
    
    let localRealm = try! Realm()
    
    func add(item:String) {
        let subscriber = Subscriber(velogId: item)
        try! localRealm.write {
            localRealm.add(subscriber)
        }
        print("add")
    }
    
    func delete(deleteId:String) {
        try! localRealm.write{
            localRealm.delete(localRealm.objects(Subscriber.self).filter("velogId == \(deleteId)"))
        }
    }

        
    // 스키마 수정 시 해야한다
    func resetDB(){
        let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
        let realmURLs = [
          realmURL,
          realmURL.appendingPathExtension("lock"),
          realmURL.appendingPathExtension("note"),
          realmURL.appendingPathExtension("management")
        ]

        for URL in realmURLs {
          do {
            try FileManager.default.removeItem(at: URL)
          } catch {
            // handle error
          }
        }
    }
    
    init() {
        print("Realm Location: ", localRealm.configuration.fileURL ?? "cannot find location.")
        }

}
