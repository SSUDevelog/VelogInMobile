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
    
    let contentsScrollView = ScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        self.getServer()

        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.getServer()
        
    }
    
    func setUI(){

        
        view.addSubview(titleLabel)
        view.addSubview(addSubscribeBtn)
        view.addSubview(contentsScrollView)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        
        addSubscribeBtn.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        contentsScrollView.snp.makeConstraints { make in
            make.top.equalTo(addSubscribeBtn.snp.bottom).offset(20)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }

    }

    
    func getServer(){

        self.provider.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]
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
