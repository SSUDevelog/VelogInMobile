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

    let addSubscribeBtn = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("Subscribe List", for: .normal)
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        setUI()
    }
    
    func setUI(){
        view.addSubview(addSubscribeBtn)
        
        addSubscribeBtn.snp.makeConstraints{
            $0.top.equalToSuperview().offset(600)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    

    
    @objc func pushView(){
        print("pushView")
        let nextVC = SubscribeListViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
