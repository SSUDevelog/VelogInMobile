//
//  SearchViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//

import UIKit
import Then
import SnapKit

class SearchViewController: UIViewController {

    
    let searchController = UISearchController()
    
    let nextButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("Next", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Keyword Search"
                
        // navigation item 에 searchController 추가
        navigationItem.searchController = searchController
        
        // UI
        setUI()
    }
    
    func setUI(){
        view.backgroundColor = .systemBackground
        view.addSubview(nextButton)
        
        nextButton.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
    
    
    
    
    @objc func pushView(){
        print("pushView")
        let nextVC = CustomTabBarController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
