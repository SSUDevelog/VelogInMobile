//
//  PostData.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/20.
//
import Foundation
struct PostData{

    static var PostListData : [SubscribePostDtoList] = [SubscribePostDtoList]()
    
    init(postListData: [SubscribePostDtoList]){
        PostData.PostListData = postListData
    }
}
