//
//  ProfileViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//
import UIKit
import SnapKit
import Then
import Foundation

class ProfileViewController: UIViewController {
    
    var cell: UITableViewCell = {
        let cell = UITableViewCell()
        return cell
    }()
    
    private let cellTitle: [String] = ["로그아웃","회원탈퇴"]
    
    private let titleLabel = UILabel().then {
        $0.text = "My Page"
        $0.font = UIFont(name: "Avenir-Black", size: 30)
    }

    let tableViewForProfile : UITableView = {
        let tableview = UITableView()
        tableview.isScrollEnabled = false
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        

        tableViewForProfile.register(UITableViewCell.self, forCellReuseIdentifier: "sectionTableViewCell")
        // Set the DataSource.
        tableViewForProfile.dataSource = self
        tableViewForProfile.delegate = self

        
        setUI()
    }
    
    func setUI(){
        
        view.addSubview(titleLabel)
        view.addSubview(tableViewForProfile)

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        tableViewForProfile.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-30)
        }

    }
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionTableViewCell", for: indexPath)
    
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "알림설정"
        case 1:
            cell.textLabel?.text = "로그아웃"
        case 2:
            cell.textLabel?.text = "회원탈퇴"
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    
}
