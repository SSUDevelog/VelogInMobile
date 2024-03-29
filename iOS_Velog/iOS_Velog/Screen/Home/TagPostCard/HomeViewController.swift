//
//  HomeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2023/02/22.
//

import Foundation
import UIKit
import Moya
import Then
import SnapKit

class HomeViewController: UIViewController {
    
    private let provider = MoyaProvider<SubscriberService>()
    private let providerForTag = MoyaProvider<TagService>()
    private let providerForSignIn = MoyaProvider<SignServices>()
    static var url:String = ""
    
    let realm = RealmService()
    
    let tableViewForTagPost : UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableViewForTagPost.register(TagPostCell.self, forCellReuseIdentifier: TagPostCell.identifier)
        tableViewForTagPost.delegate = self
        tableViewForTagPost.dataSource = self
        
        tableViewForTagPost.reloadData()
        
        if realm.getIsUser() != "true" {
            // 일단 빌드 한번할 때 마다 SignIn API 호출하고 있다.
            print("FCM 토큰 넣고 로그인 API 한번 더 호출")
            self.postServer()
        }
        
        setUI()
    }

    override func viewWillAppear(_ animated: Bool) {
//        getPostDataServer()
        tableViewForTagPost.reloadData()
    }
    
    
    func setUI(){

        view.addSubview(tableViewForTagPost)

        tableViewForTagPost.snp.makeConstraints {
            $0.top.equalToSuperview().offset(185)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-90)
        }
    }
    
    func postServer(){
        // server
        
        let id = self.realm.getProfileID()
        let pw = self.realm.getProfilePW()
        
        let param = SignInRequest.init(SignInViewController.FcmToken, id, pw)
        print(param)
        self.providerForSignIn.request(.signIn(param: param)){ response in
            switch response {
                case .success(let moyaResponse):
                    do {
                        let responseData = try moyaResponse.map(SigninResponse.self)
                        // 로컬에 토큰 저장
                        self.addTokenInRealm(item: responseData.token)
                        self.addIsUserInRealm(input: "true")
                        print("this is your second signIn")
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
    }

    func addTokenInRealm(item:String){
        // add token in realm
        realm.addToken(item: item)
        print(item)
    }
    
    func addIsUserInRealm(input:String){
        realm.addisUser(input: input)
        print(input)
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
        self.providerForTag.request(.gettag){ [self] response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userTag.List = try moyaResponse.mapJSON() as! [String]
                    resetTagURL(indexSize: TagPostData.Post.tagPostDtoList.count)
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
        self.providerForTag.request(.tagpost){ [self] response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPostTag")
                    print(moyaResponse.statusCode)
                    TagPostData.Post = try moyaResponse.map(PostTagList.self)
                    // for test
                    print(TagPostData.Post.tagPostDtoList.count)
//                    resetTagURL(indexSize: TagPostData.Post.tagPostDtoList.count)
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
    func pushWebView(url:String){
        print("finish to push WebView")

        let nextVC = PostWebViewController(url: url)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

    func resetURL(indexSize:Int){
        
        urlList.list.removeAll()
        
        for x in 0..<indexSize {
            urlList.list.append(PostData.Post.subscribePostDtoList[x].url)
        }
        
        for x in 0..<indexSize {
            print(urlList.list[x])
        }
        
    }
    
    func resetTagURL(indexSize:Int){
        TagaUrlList.list.removeAll()
        for x in 0..<indexSize {
            TagaUrlList.list.append(TagPostData.Post.tagPostDtoList[x].url)
        }
    }
}


extension HomeViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        print("cell did touched")
        HomeViewController.url = TagaUrlList.list[indexPath.row]
        
//        PostWebViewController.url = URL(string: url)
        print(HomeViewController.url)  // 일단 좋아!!! 여기까지
        self.pushWebView(url: HomeViewController.url)
    }
}


extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(TagPostData.Post.tagPostDtoList.count)
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
