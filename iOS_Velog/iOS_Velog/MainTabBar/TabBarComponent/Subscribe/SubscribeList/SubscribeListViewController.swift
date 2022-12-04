//
//  SubscribeListViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//

import UIKit
import SnapKit
import Then
import Moya


class SubscribeListViewController: UIViewController {
    
    private let provider = MoyaProvider<SubscriberService>()
//    var responseData: SubscriberListResponse?
    
    let titleLabel = UILabel().then {
        $0.text = "Subscribe List"
        $0.font = UIFont(name: "Avenir-Black", size: 40)
    }
    
    // 구독 리스트 tableView
    let tableViewForSubscribeList :UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        tableViewForSubscribeList.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableViewForSubscribeList.delegate = self
        tableViewForSubscribeList.dataSource = self
        
        // 구독자 추가한 다음에 구독자 리스트 뷰로 들어오니까, 여기서 구독자 글 목록 불러오자!
        getPostDataServer()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetSubScribeList()
    
    }
    
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    print(moyaResponse.statusCode)
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


    // 구독 서치에서 추가된 경우 Realm을 다시 서치한다.
    func resetSubScribeList(){
//        getServer()
        tableViewForSubscribeList.reloadData()
    }
    
    func getServer(){
        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{

                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]

                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func setUI(){

        view.addSubview(tableViewForSubscribeList)

        tableViewForSubscribeList.snp.makeConstraints{
            $0.top.equalToSuperview().offset(250)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-90)
        }
    }
 
    @objc func addSubscribe(){
        print("pushView")
        let nextVC = SearchSubscribeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 구독자 리스트에서 특정 구독자 삭제
    func deleteSubscriberList(targetName:String){
        self.provider.request(.unsubscribe(targetName)){ response in
            switch response {
            case .success(let moyaResponse):
                do {    // 여기서 do 가 필요할까?
                    print(moyaResponse.statusCode)
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

}

extension SubscribeListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as? CustomCell ?? CustomCell()
        cell.bind(model: userList.List[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            tableView.beginUpdates()
            self.deleteSubscriberList(targetName: userList.List.remove(at: indexPath.row))
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}
