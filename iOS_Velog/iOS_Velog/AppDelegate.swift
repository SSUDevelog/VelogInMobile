//
//  AppDelegate.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/08.
//

import UIKit
import Firebase
import FirebaseCore
import UserNotifications
import UserNotificationsUI


@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    static var FcmToken:String!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = self
        Messaging.messaging().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter
          .current()
          .requestAuthorization(
            options: authOptions,completionHandler: { (_, _) in }
          )
        application.registerForRemoteNotifications()
        return true
    }

    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }


}

extension AppDelegate : MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        SignInViewController.FcmToken = fcmToken
        print("파이어베이스 토큰: \(String(describing: fcmToken))")
//        print(SignInViewController.FcmToken!)
    }
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Received data message: \(remoteMessage.appData)")
//    }
}

extension AppDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("foreground")
//        print(notification.request.content.body)    // body
//        print(notification.request.content.title)   // title
        let dicData = notification.request.content.userInfo
        print(dicData)
        var pushTitle = ""
        var pushMessage = ""
        var pushLink = ""
        
        if dicData.keys.contains("aps") {
            let apsDic = dicData["aps"] as! [String: Any]
            
            if (apsDic.keys.contains("alert")){
                let alert = apsDic["alert"] as! [String: Any]
                pushTitle = String(describing: alert["title"] ?? "")
                pushMessage = String(describing: alert["body"] ?? "")
                print(pushTitle)
                print(pushMessage)
            }
        }
        
        if dicData.keys.contains("link") {
            let linkDic = dicData["link"] ?? ""
            pushLink = linkDic as! String
            print(pushLink)
        }
        completionHandler([.alert, .badge, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print(userInfo)
        print("background")
        print(response.notification.request.content.title)
        print(response.notification.request.content.body)
        print(response.notification.request.content.subtitle)
        // [completionHandler : 푸시 알림 상태창 표시]
        completionHandler()
    }
}
