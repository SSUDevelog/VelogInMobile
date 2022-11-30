//
//  HomeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/28.
//

import UIKit
import Moya

class HomeViewController: UIViewController {
    
    

    private let provider = MoyaProvider<SubscriberService>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        getPostDataServer()
    }
//    override func viewWillAppear(_ animated: Bool) {
//        print(PostData.Post.subscribePostDtoList.first?.title as Any)
//        print(PostData.Post.subscribePostDtoList.count)
//    }
    
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    print(moyaResponse.statusCode)
//                    var postList = PostData(data: try moyaResponse.map(PostList.self))
                    PostData.Post = try moyaResponse.map(PostList.self)
                    print(PostData.Post.subscribePostDtoList.count)
                    print("성공")
                }catch(let err){
                    print(err.localizedDescription)
                    print("맵핑 안됨")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}
