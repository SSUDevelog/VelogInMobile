//
//  ProfileViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//

import UIKit
import SnapKit
import Then

class ProfileViewController: UIViewController {
    
    private let titleLabel = UILabel().then {
        $0.text = "My Page"
        $0.font = UIFont(name: "Avenir-Black", size: 30)
    }
    
    let switchforSubscription = UISwitch().then {
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.onTintColor = UIColor.customColor(.defaultBackgroundColor)
    }
    
    let tableViewForProfile : UITableView = {
        let tableview = UITableView()
//        tableview.backgroundColor = .red
        return tableview
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        setUI()
    }
    
    func setUI(){
        
        view.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }

    }
    
}





