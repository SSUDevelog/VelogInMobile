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

    let realm = RealmService()
    
    private let provider = MoyaProvider<SubscriberService>()
    var responseData: SubscriberListResponse?
    
    let titleLabel = UILabel().then {
        $0.text = "Notification"
        $0.font = UIFont(name: "Avenir-Black", size: 30)
    }
    
//    var imgView: UIImageView = {
//        let view = UIImageView()
//        view.image = UIImage(systemName: "pencil")
//        view.contentMode = .scaleAspectFit
//        view.clipsToBounds = true
//        view.snp.makeConstraints { make in
//            make.height.equalTo(150)
//        }
//        return view
//    }()
    
    let noText = UILabel().then {
        $0.text = "추후 개발 예정입니다."
        $0.font = UIFont(name: "Avenir-Black", size: 20)
    }
    
    let no2Text = UILabel().then {
        $0.text = "구독자들이 새로운 글을 썼을 때"
    }
    
    let no3Text = UILabel().then{
        $0.text = "새 글 알림을 보내도록 구현할 예정"
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
//        getServer()
        tableViewForNotificationList.reloadData()
    }
    
    // 여기 원래 알림 데이터 들어와야 하는데 일단 구독자로 대체
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    
                    print(moyaResponse.statusCode)
//                    NotificationList.notificationList = try moyaResponse.mapJSON() as! [String]

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
        // 일단 알림 구현하기 전까지는 보류
//        view.addSubview(tableViewForNotificationList)
        view.addSubview(noText)
        view.addSubview(no2Text)
        view.addSubview(no3Text)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
            
        noText.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        no2Text.snp.makeConstraints { make in
            make.top.equalTo(noText.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        no3Text.snp.makeConstraints { make in
            make.top.equalTo(no2Text.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        // 일단 알림 구현하기 전까지는 보류
//        tableViewForNotificationList.snp.makeConstraints { make in
//            make.top.equalTo(titleLabel.snp.bottom).offset(30)
//            make.leading.equalToSuperview().offset(30)
//            make.trailing.equalToSuperview().offset(-30)
//            make.bottom.equalToSuperview().offset(-90)
//
//        }
        
        
        
    }

}

extension NotificationViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return NotificationList.notificationTitleList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NotificationTableViewCell.identifier) as? NotificationTableViewCell ?? NotificationTableViewCell()

//        cell.bindForNotification(title: NotificationList.notificationList[indexPath.row][0], body: NotificationList.notificationList[indexPath.row][1])
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
