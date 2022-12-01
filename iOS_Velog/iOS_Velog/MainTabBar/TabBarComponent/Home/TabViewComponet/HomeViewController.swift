//
//  HomeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/28.
//

import Foundation
import UIKit
import Moya
import Then
import SnapKit

class HomeViewController: UIViewController {
    
    private let provider = MoyaProvider<SubscriberService>()

    
    let tableViewForTagPost : UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .red
        return tableview
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        

        // 데이터 띄우기 직전 뷰에서 서버 통신해서 데이터 미리 받아놓아야 한다!!
        getPostDataServer()
        
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        getPostDataServer()
    }
    
    
    func setUI(){

        view.addSubview(tableViewForTagPost)

        
        tableViewForTagPost.snp.makeConstraints {
            $0.top.equalToSuperview().offset(250)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-90)
        }
    }

    
    
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    
                    print(moyaResponse.statusCode)
                    PostData.Post = try moyaResponse.map(PostList.self)
                    self.resetURL(indexSize: PostData.Post.subscribePostDtoList.count)
                    
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
    
    func resetURL(indexSize:Int){
        
        for x in 0..<indexSize {
            urlList.list.append(PostData.Post.subscribePostDtoList[x].url)
        }
        
//        for x in 0..<indexSize {
//            print(urlList.list[x])
//        }
        
    }
    
}
