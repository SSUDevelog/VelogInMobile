//
//  SubscribeListViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//

import UIKit
import SnapKit
import Then

class SubscribeListViewController: UIViewController {

    let titleLabel = UILabel().then {
        $0.text = "Subscribe List"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let addButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("add Subscribe", for: .normal)
        $0.addTarget(self, action: #selector(addSubscribe), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black  // navigation back btn color change
        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        addButton.snp.makeConstraints{
//            $0.top.equalToSuperview().offset(200)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
    }
 
    @objc func addSubscribe(){
        print("pushView")
        let nextVC = SearchSubscribeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
