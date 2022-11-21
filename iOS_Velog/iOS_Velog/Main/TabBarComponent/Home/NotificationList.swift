//
//  Notification.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import Foundation
struct NotificationList{
    static var notificationList = [String]()
    
    init(notificationList:[String]){
        NotificationList.notificationList = notificationList
    }
}
