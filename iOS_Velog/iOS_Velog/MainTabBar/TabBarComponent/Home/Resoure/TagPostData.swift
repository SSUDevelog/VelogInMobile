//
//  TagPostData.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import Foundation

struct TagPostData{
    
    static var Post = PostTagList()
    
    init(data:PostTagList){
        TagPostData.Post = data
    }
}

