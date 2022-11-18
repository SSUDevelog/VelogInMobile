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
    var responseData: SubscriberListResponse?
    
    var subScribeList = [String]()

    let titleLabel = UILabel().then {
        $0.text = "Subscribe"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let addSubscribeBtn = UIButton().then{
        $0.setTitleColor(UIColor.customColor(.defaultBackgroundColor), for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.customColor(.pointColor)
        $0.setTitle("My Subscribe List", for: .normal)
        
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
//        self.getServer()
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getServer()
        
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(addSubscribeBtn)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        addSubscribeBtn.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(90)
            $0.trailing.equalToSuperview().offset(-90)
        }
    }
    
    
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
//                    self.subScribeList = try moyaResponse.mapJSON() as! [String]
                    userList.List = try moyaResponse.mapJSON() as! [String]
                    print(userList.List)
//                    print(self.subScribeList)   // 서버에서 구독자 리스트 받아와서 subscriberList 에 저장
                
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
