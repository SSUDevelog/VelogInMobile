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
    
    func addToken(item:String){
        let token =  Token(token: item)
        try! localRealm.write{
            localRealm.add(token)
        }
    }
    
    func addProfile(ID:String,PW:String){
        let profile = Profile(ID: ID, PW: PW)
        try! localRealm.write{
            localRealm.add(profile)
        }
    }
    
    // 여기서 isUser는 FCM Token을 넣은 상태의 SignIn API를 호출한 유저를 뜻함
    func addisUser(input:String){
        let isUser = isUser(input: input)
        try! localRealm.write{
            localRealm.add(isUser)
        }
    }
    
    func addNotificationForNewPost(title:String,body:String,link:String){
        let notificationForNewPost = notificationForNewPost(title: title, body: body, link: link)
        try! localRealm.write{
            localRealm.add(notificationForNewPost)
        }
    }
    
    func getToken()->String{
        let token = localRealm.objects(Token.self)
        //        return token[0].token
        // 가장 마지막 토큰을 헤더에 넣기
        return token.last?.token ?? ""
    }
    
    func getProfileID()->String{
        let profile = localRealm.objects(Profile.self)
        return profile.last?.ID ?? ""
    }
    
    func getProfilePW()->String{
        let profile = localRealm.objects(Profile.self)
        return profile.last?.PW ?? ""
    }
    
    func getIsUser()->String{
        let isUser = localRealm.objects(isUser.self)
        return isUser.last?.isuser ?? ""
    }
    
    func getNotificationTitle()->String{
        let notification = localRealm.objects(notificationForNewPost.self)
        return notification.last?.title ?? ""
    }
    
    func getNotificationBody(index:Int)->String{
        let notification = localRealm.objects(notificationForNewPost.self)
        return notification.last?.body ?? ""
    }
    
    func getNotificationLink(index:Int)->String{
        let notification = localRealm.objects(notificationForNewPost.self)
        return notification.last?.link ?? ""
    }
    
    func delete(deleteId:String) {
        try! localRealm.write{
            localRealm.delete(localRealm.objects(Subscriber.self).filter("velogId == \(deleteId)"))
        }
        print("deleted")
    }
    
    func readDB(){
        let subScriber = localRealm.objects(Subscriber.self)
        print(subScriber)
    }

        
    // 스키마 수정시 한번 돌려야 한다.
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
//        print("Realm Location: ", localRealm.configuration.fileURL ?? "cannot find location.")
    }

}
