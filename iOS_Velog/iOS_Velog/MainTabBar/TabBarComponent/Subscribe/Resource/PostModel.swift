//
//  PostModel.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/20.
//

import Foundation

// MARK: - Welcome
struct PostList: Codable {
    var subscribePostDtoList =  [SubscribePostDtoList]()
}

// MARK: - SubscribePostDtoList
struct SubscribePostDtoList: Codable {
    let comment: Int
    let date, img: String
    let like: Int
    let name, summary: String
    let tag: [String]
    let title, url: String
    
    init(comment: Int, date: String, img: String, like: Int, name: String, summary: String, tag: [String], title: String, url: String) {
        self.comment = comment
        self.date = date
        self.img = img
        self.like = like
        self.name = name
        self.summary = summary
        self.tag = tag
        self.title = title
        self.url = url
    }

}

