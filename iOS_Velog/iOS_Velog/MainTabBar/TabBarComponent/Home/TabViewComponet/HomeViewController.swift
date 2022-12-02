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
    private let providerForTag = MoyaProvider<TagService>()
    static var url:String = ""
//    let PostVC = PostWebViewController()
    
    let tableViewForTagPost : UITableView = {
        let tableview = UITableView()
//        tableview.backgroundColor = .red
        return tableview
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // 일단... 어디 넣을지 몰라서 ...
//        getTagPostDataServer() // 서버 업데이트 되면 돌려보자
        print("HomeView")
        // 데이터 띄우기 직전 뷰에서 서버 통신해서 데이터 미리 받아놓아야 한다!!
        getPostDataServer()
        getServerTag()
        getTagPostDataServer()
        
        tableViewForTagPost.register(TagPostCell.self, forCellReuseIdentifier: TagPostCell.identifier)
//        tableViewForTagPost.delegate = self
        tableViewForTagPost.dataSource = self
        
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        getPostDataServer()
        tableViewForTagPost.reloadData()
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
    
    // 태그 추가했을 경우 서버 디비 재호출
    func getServerTag(){
        self.providerForTag.request(.gettag){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userTag.List = try moyaResponse.mapJSON() as! [String]
                    print(userTag.List)
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // 태그 맞춤 글 추천 아직 어디에 사용할 지 모름, 이런
    func getTagPostDataServer(){
        self.providerForTag.request(.tagpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPostTag")
                    print(moyaResponse.statusCode)
                    TagPostData.Post = try moyaResponse.map(PostTagList.self)
                    // for test
                    print(TagPostData.Post.tagPostDtoList.count)
                    self.resetTagURL(indexSize: TagPostData.Post.tagPostDtoList.count)
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
    
    // webView 푸시
    func pushWebView(){
        print("finish to push WebView")
        let nextVC = PostWebViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func resetURL(indexSize:Int){
        
        for x in 0..<indexSize {
            urlList.list.append(PostData.Post.subscribePostDtoList[x].url)
        }
        
//        for x in 0..<indexSize {
//            print(urlList.list[x])
//        }
        
    }
    
    func resetTagURL(indexSize:Int){
        
        for x in 0..<indexSize {
            TagaUrlList.list.append(TagPostData.Post.tagPostDtoList[x].url)
        }
    }
    
}

extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        HomeViewController.url = TagaUrlList.list[indexPath.row]
        
//        PostWebViewController.url = URL(string: url)
        print(HomeViewController.url)  // 일단 좋아!!! 여기까지
        self.pushWebView()
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TagPostData.Post.tagPostDtoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagPostCell.identifier, for: indexPath) as? TagPostCell ?? TagPostCell()
        cell.binding(model: TagPostData.Post.tagPostDtoList[indexPath.row])

        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}
