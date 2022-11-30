//
//  PostData.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/20.
//
//struct PostData{
//
//    static var PostListData = [SubscribePostDtoList]()
//
//    init(postListData: [SubscribePostDtoList]){
//        PostData.PostListData = postListData
//    }
//}
//struct PostData{
//
//    static var PostListData = [SubscribePostDtoList]()
//
//    init(postListData: PostList){
////        PostData.PostListData = postListData
//        PostData.PostListData = pos
//    }
//}


import Foundation
struct PostData{
//    static var Post = [SubscribePostDtoList]()
    static var Post = PostList()
    
    init(data:PostList){
        PostData.Post = data
    }
}

