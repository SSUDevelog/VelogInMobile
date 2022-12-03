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
    
    let tabelCell1: UITableViewCell = {
        let tableCell = UITableViewCell()
        tableCell.backgroundColor = .red
        return tableCell
    }()
    
    let tableCell2: UITableViewCell = {
        let tableCell = UITableViewCell()
        tableCell.backgroundColor = .blue
        return tableCell
    }()
    
    let tableCell3: UITableViewCell = {
        let tableCell = UITableViewCell()
        tableCell.backgroundColor = .black
        return tableCell
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        setUI()
    }
    
    func setUI(){
        
        view.addSubview(titleLabel)
        view.addSubview(tableViewForProfile)
        tableViewForProfile.addSubview(tabelCell1)
        tableViewForProfile.addSubview(tableCell2)
        tableViewForProfile.addSubview(tableCell3)
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        tableViewForProfile.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.bottom.equalToSuperview().offset(-30)
        }

    }
    
}

//extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//
//        return 5
//
//    }
//
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CodingCustomTableViewCell", for: indexPath) as? CodingCustomTableViewCell else { return UITableViewCell() }
//
//
//
//        return cell
//
//    }
//
//}
