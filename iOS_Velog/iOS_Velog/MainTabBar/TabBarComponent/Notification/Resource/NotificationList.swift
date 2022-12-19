//
//  Notification.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import Foundation


struct NotificationList{
    static var notificationList = [String,String,String]()
    
    init(notificationList:[String,String,String]){
        NotificationList.notificationList = notificationList
    }
}
