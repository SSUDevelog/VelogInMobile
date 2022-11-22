//
//  SubScribeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//

import UIKit
import SnapKit
import Then
import Moya

class SubScribeViewController: UIViewController {
    
    private let provider = MoyaProvider<SubscriberService>()
//    var responseData: SubscriberListResponse?
//    let responseData: onePostModel? = nil
//    var responseData: PostList?
    
    
    let titleLabel = UILabel().then {
        $0.text = "Subscribe"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let addSubscribeBtn = UIButton().then{
        $0.setTitleColor(UIColor.customColor(.defaultBackgroundColor), for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.customColor(.pointColor)
        $0.setTitle("Subscribe List", for: .normal)
        
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    let scrollview = ScrollView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
//        navigationController?.navigationBar.tintColor = .black
        
        self.getServer()
//        self.getPostDataServer()
        
        self.setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getServer()
        self.getPostDataServer()
    }
    
    func setUI(){
        
//        view.addSubview(titleLabel)
//        view.addSubview(addSubscribeBtn)
        view.addSubview(scrollview)
        
//        titleLabel.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(100)
//            $0.centerX.equalToSuperview()
//        }
        
//        addSubscribeBtn.snp.makeConstraints{
//            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
//            $0.leading.equalToSuperview().offset(200)
//            $0.trailing.equalToSuperview().offset(-30)
//        }
        
        scrollview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(250)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
        }

    }

    
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    print(moyaResponse.statusCode)
                    print(try moyaResponse.mapJSON())
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

    
    @objc func pushView(){
        print("pushView")
        let nextVC = SubscribeListViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
