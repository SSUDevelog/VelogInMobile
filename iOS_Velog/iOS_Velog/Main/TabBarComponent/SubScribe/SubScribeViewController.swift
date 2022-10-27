//
//  SubScribeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//

import UIKit
import SnapKit
import Then

class SubScribeViewController: UIViewController {

    let titleLabel = UILabel().then {
        $0.text = "Subscribe"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let addSubscribeBtn = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("My Subscribe List", for: .normal)
        
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        setUI()
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(addSubscribeBtn)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        addSubscribeBtn.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    

    
    @objc func pushView(){
        print("pushView")
        let nextVC = SubscribeListViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
