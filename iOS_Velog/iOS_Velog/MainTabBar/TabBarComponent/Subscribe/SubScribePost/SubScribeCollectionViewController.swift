//
//  SubScribeCollectionViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import UIKit
import SnapKit
import Then
import Moya





class SubScribeCollectionViewController: UIViewController {
    
    
    let d1: SubscribePostDtoList = SubscribePostDtoList(comment: 3, date: "2022.10.2", img: "", like: 3, name: "joon", summary: "경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나", tag: ["swift","iOS"], title: "함께 일하고 싶은 사람", url: "https://velog.io/@city7310/%ED%95%A8%EA%BB%98-%EC%9D%BC%ED%95%98%EA%B3%A0-%EC%8B%B6%EC%9D%80-%EC%82%AC%EB%9E%8C-1.-%EC%97%85%EB%AC%B4-%EC%8A%B5%EA%B4%80-w1mfhsf2")
    
    let d2: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.10.7", img: "", like: 7, name: "Kim", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    
//    let d3: SubscribePostDtoList
    
    lazy var dummy: [SubscribePostDtoList] = [d1, d2]
    
    
    private let provider = MoyaProvider<SubscriberService>()
    
//    private var collectionView:UICollectionView?
    
//    let layout = UICollectionViewFlowLayout()

    let PostVC = PostWebViewController()
    
    // 구독 리스트 tableView
    let tableViewForPosts :UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tableViewForPosts.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableViewForPosts.delegate = self
        tableViewForPosts.dataSource = self
        
//        setCellLayer()
        
//        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//
//        guard let collectionView = collectionView else {
//            return
//        }
        
//        CustomCollectionViewCell.self
//        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
//        collectionView.dataSource = self
//        collectionView.delegate = self
//
//        view.addSubview(collectionView)
//        collectionView.frame = view.bounds
//
//        collectionView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(250)
//            make.leading.equalToSuperview().offset(25)
//            make.trailing.equalToSuperview().offset(-20)
//            make.bottom.equalToSuperview().offset(-30)
//        }
//        view.backgroundColor = .systemBackground
        
        
        setUI()
    }
    
    func setUI(){
        view.addSubview(tableViewForPosts)
        
        tableViewForPosts.snp.makeConstraints {
            $0.top.equalToSuperview().offset(250)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-90)
        }
    }
    
//    func setCellLayer(){
//        layout.scrollDirection = .vertical
//        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height/3)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getServer()
//        self.getPostDataServer() // 아직 사용하지 않는다
    }
    
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(_):
                do{
                    print("getPost")
//                    print(moyaResponse.statusCode)
//                    print(try moyaResponse.mapJSON())
//                    var responseData = try moyaResponse.mapJSON()
//                    var responseDataa = try JSONSerialization.
                    print("과연 성공?")
                    
//                    print(responseDataa)
//                    print("과연 성공?")
                    print("성공")  // 여기까지는 들어온다.
                    
                }catch(let err){
                    print(err.localizedDescription)
                    print("맵핑 안됨")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]
//                     이거 임시!!!
                    NotificationList.notificationList = try moyaResponse.mapJSON() as! [String]
                    print(userList.List)
                    
                }catch(let err) {
                    print(err.localizedDescription)
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


}

//extension SubScribeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
////        cell.contentView.backgroundColor = .systemBlue
////        cell.configure(title: "Custom \(indexPath.row)", textViewText: <#T##String#>, name: <#T##String#>, date: <#T##String#>)
//        // 이걸로 cell 초기화!!
//        return cell
//    }
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        print("didSelectItemAt")
//        print("\(indexPath)")
//
//        pushWebView()
//    }
//
//
//}

extension SubScribeCollectionViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return PostData.PostListData.count    // decoding 전까지
        return self.dummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier) as? PostCell ?? PostCell()
//        cell.binding(model: PostData.PostListData[indexPath.row]) // decoding 전까지
        cell.binding(model: self.dummy[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
