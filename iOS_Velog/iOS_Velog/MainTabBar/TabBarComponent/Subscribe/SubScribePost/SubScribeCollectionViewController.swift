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
    
    
    
    let d1: SubscribePostDtoList = SubscribePostDtoList(comment: 3, date: "2022.10.2", img: "", like: 3, name: "1", summary: "경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나", tag: ["swift","iOS"], title: "함께 일하고 싶은 사람1", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    
    let d2: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.10.7", img: "", like: 7, name: "2", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나2", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@lky5697/react-junior-code-review-and-refactoring")
    
    let d3: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.11.20", img: "", like: 7, name: "3", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다.3", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wksmstkfka12/%EA%B0%9C%EB%B0%9C%EC%9D%84-%EC%A2%8B%EC%95%84%ED%95%9C%EB%8B%A4%EB%8A%94-%EA%B2%83")
    
    let d4: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "4", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지4", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    let d5: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "5", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지5", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    let d6: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "6", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지6", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    
    let d7: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "7", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지6", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    let d8: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "8", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지6", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    let d9: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "9", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지6", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    let d10: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "10", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지6", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")
    let d11: SubscribePostDtoList = SubscribePostDtoList(comment: 5, date: "2022.09.10", img: "", like: 7, name: "11", summary: "국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나 료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 국비지원 수료부터 스타트업 입사, 퇴사고민까지. 10월~11월 회고 경력을 시작한 지 2년 쯤 지6", tag: ["백엔드","스타트업","취업","핀테크","회고"], title: "22년 4분기 회고 : 첫 취업 후기(feat.스타트업)", url: "https://velog.io/@wijoonwu/22%EB%85%84-4%EB%B6%84%EA%B8%B0-%ED%9A%8C%EA%B3%A0-%EC%B2%AB-%EC%B7%A8%EC%97%85-%ED%9B%84%EA%B8%B0feat.%EC%8A%A4%ED%83%80%ED%8A%B8%EC%97%85")


    
    
    lazy var dummy: [SubscribePostDtoList] = [d1, d2, d3, d4, d5, d6, d7, d8,d9,d10,d11]
    var dumy:PostList?
    
    
    private let provider = MoyaProvider<SubscriberService>()

    let PostVC = PostWebViewController()
    
    // 구독 리스트 tableView
    let tableViewForPosts :UITableView = {
        let tableview = UITableView()
//        tableview.backgroundColor = .red
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tableViewForPosts.register(PostCell.self, forCellReuseIdentifier: PostCell.identifier)
        tableViewForPosts.delegate = self
        tableViewForPosts.dataSource = self
        self.getPostDataServer()
        setUI()
        print(PostData.Post.subscribePostDtoList)
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

    
    override func viewWillAppear(_ animated: Bool) {
        self.getServer()
        self.getPostDataServer() // 아직 사용하지 않는다
    }
    
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    print(moyaResponse.statusCode)
//                    var postList = PostData(data: try moyaResponse.map(PostList.self))
//                    PostData.Post = try moyaResponse.map(PostList.self)
                    PostData.Post = try moyaResponse.map(PostList.self)
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

extension SubScribeCollectionViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var url:String = dummy[indexPath.row].url
        print(dummy[indexPath.row].url)
//        self.PostVC.resetURL(url: url)
//        self.navigationController?.pushViewController(PostVC, animated: true)
        PostWebViewController.url = URL(string: url)
        self.pushWebView()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        print("Will Display Cell : \(indexPath.row)")
        
    }
    
    func tableView(_ tableView: UITableView,
                   didEndDisplaying cell: UITableViewCell,
                   forRowAt indexPath: IndexPath) {
      print("Did End Display Cell : \(indexPath.row)")
    }
}


extension SubScribeCollectionViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dummy.count
//        return PostData.Post.count
//        return 1
        return PostData.Post.subscribePostDtoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostCell.identifier, for: indexPath) as? PostCell ?? PostCell()
//        cell.binding(model: PostData.PostListData[indexPath.row]) // decoding 전까지
//        cell.binding(model: self.dummy[indexPath.row])
//        cell.binding(model: PostData.Post[indexPath.row])
        cell.binding(model: PostData.Post.subscribePostDtoList[indexPath.row])
//        cell.binding(model: PostData.Post.first)
//        print(PostData.Post.first!)
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
}


