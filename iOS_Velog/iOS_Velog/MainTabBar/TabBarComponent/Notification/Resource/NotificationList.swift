//
//  Notification.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import Foundation


struct NotificationList{
    static var notificationTitleList = [String]()
    static var notificationBodyList = [String]()
    static var notificationLinkList = [String]()
    
    init(notificationTitle:String,notificationBody:String,notificationLink:String){
        
        NotificationList.notificationTitleList.append(notificationTitle)
        NotificationList.notificationBodyList.append(notificationBody)
        NotificationList.notificationLinkList.append(notificationLink)
    }
}
