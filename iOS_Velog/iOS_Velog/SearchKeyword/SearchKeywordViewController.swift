//
//  SearchKeywordViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//

import Foundation
import UIKit
import SnapKit

class SearchKeywordViewController:UIViewController{
    
    
    let nextButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("Next", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUI()
    }
    
    func setUI(){
        view.addSubview(nextButton)
        
        
        
        nextButton.snp.makeConstraints{
            $0.top.equalToSuperview().offset(200)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(250)
        }
    }
    
    @objc func pushView(){
        print("pushView")
        let nextVC = CustomTabBarController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
