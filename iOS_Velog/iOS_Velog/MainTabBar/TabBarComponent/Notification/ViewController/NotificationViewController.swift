//
//  NotificationViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import UIKit
import Then
import SnapKit
import Moya

class NotificationViewController: UIViewController {

    private let provider = MoyaProvider<SubscriberService>()
    var responseData: SubscriberListResponse?
    
    let titleLabel = UILabel().then {
        $0.text = "Notification"
        $0.font = UIFont(name: "Avenir-Black", size: 30)
    }
    
    // 구독 리스트 tableView
    let tableViewForNotificationList :UITableView = {
        let tableview = UITableView()
        return tableview
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
//        print(NotificationList.notificationList)
        
        tableViewForNotificationList.register(NotificationTableViewCell.self, forCellReuseIdentifier: NotificationTableViewCell.identifier)
        tableViewForNotificationList.delegate = self
        tableViewForNotificationList.dataSource = self
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetNotificationList()
    }
    
    func resetNotificationList(){
//        tableViewForSubscribeList.reloadData()
        getServer()
        tableViewForNotificationList.reloadData()
    }
    
    // 여기 원래 알림 데이터 들어와야 하는데 일단 구독자로 대체
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    
                    print(moyaResponse.statusCode)
                    NotificationList.notificationList = try moyaResponse.mapJSON() as! [String]

                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(tableViewForNotificationList)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
            
        tableViewForNotificationList.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-90)
            
        }
        
    }

}

extension NotificationViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return data.count // 더미 데이터 코드
//        return userList.List.count
        return NotificationList.notificationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier) as? NotificationTableViewCell ?? NotificationTableViewCell()
        cell.bind(model: NotificationList.notificationList[indexPath.row])
//        cell.rightButton.addTarget(self, action: #selector(deleteBtnAction), for: .touchUpInside)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
