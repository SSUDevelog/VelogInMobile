//
//  PostModel.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/20.
//

import Foundation

struct PostList:Codable {
    let subscribePostDtoList: [SubscribePostDtoList]
}

// MARK: - SubscribePostDtoList
struct SubscribePostDtoList:Codable {
    let comment: Int
    let date, img: String
    let like: Int
    let name, summary: String
    let tag: [String]
    let title, url: String
}
