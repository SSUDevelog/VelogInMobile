//
//  TagViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import UIKit
import Foundation
import Then
import SnapKit
import Moya

class TagViewController: UIViewController {
    
    // 태그 리스트 tableView
    let tableViewForTag :UITableView = {
        let tableview = UITableView()
        tableview.backgroundColor = .blue
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI(){

        view.addSubview(tableViewForTag)

        tableViewForTag.snp.makeConstraints { 
            $0.top.equalToSuperview().offset(250)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalToSuperview().offset(-90)
        }
    }
    
}
