//
//  SearchKeywordViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//

import Foundation
import UIKit
import SnapKit
import Then

// Search View 로 들어가기 전에 한번 거르는 뷰
class SearchKeywordViewController:UIViewController{
    
    let titleLabel = UILabel().then{
        $0.text = "Choose"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let titleLabel2 = UILabel().then{
        $0.text = "Keyword"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let nextButtonForSearchKeyword = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("keyword 입력할래요.", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }

    let nextButtonForHome = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("일단 시작할래요.", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushView2), for: .touchUpInside)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        self.navigationItem.hidesBackButton = true

        
        setUI()
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(titleLabel2)
        view.addSubview(nextButtonForSearchKeyword)
        view.addSubview(nextButtonForHome)


        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(30)
        }

        titleLabel2.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(30)
        }
        
        nextButtonForSearchKeyword.snp.makeConstraints{
            $0.top.equalTo(titleLabel2.snp.bottom).offset(100)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(30)
        }
        
        nextButtonForHome.snp.makeConstraints{
            $0.top.equalTo(nextButtonForSearchKeyword.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    
    @objc func pushView(){
        print("pushView")
        let nextVC = SearchViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func pushView2(){
        print("pushView2")
        let nextVC = CustomTabBarController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
