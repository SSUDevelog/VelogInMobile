//
//  PostData.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/20.
//
import Foundation
struct PostData{

    static var PostListData : Dictionary<String, Any> = [String : Any]()
    
    init(postListData:Dictionary<String, Any>){
        PostData.PostListData = postListData
    }
}

