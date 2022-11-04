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
    
    // for 더미 데이터
    var data = [CustomCellModel]()
    
    
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

    let tableViewForSubscribeList :UITableView = {
        let tableview = UITableView()
        
        return tableview
    }()
    
    let pracBtn:UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(addBtnAction), for: .touchUpInside)
        btn.setTitle("+", for: .normal)
        btn.layer.cornerRadius = 10
        btn.backgroundColor = UIColor.customColor(.defaultBlackColor)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.tintColor = .black  // navigation back btn color change
        
        tableViewForSubscribeList.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
        tableViewForSubscribeList.delegate = self
        tableViewForSubscribeList.dataSource = self
        
        // Do any additional setup after loading the view.
        setUI()
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(addButton)
        view.addSubview(tableViewForSubscribeList)
        view.addSubview(pracBtn)
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        addButton.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        pracBtn.snp.makeConstraints{
            $0.bottom.equalToSuperview().offset(-60)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        tableViewForSubscribeList.snp.makeConstraints{
            $0.top.equalTo(addButton.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
            $0.bottom.equalTo(pracBtn.snp.top).offset(-20)
        }
        

        
    }
 
    @objc func addSubscribe(){
        print("pushView")
        let nextVC = SearchSubscribeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func addBtnAction() {
        print("addBtn")
        data.append(.init(leftTitle: "cell\(data.count)"))
        tableViewForSubscribeList.reloadData()
    }
    
    
    
    
    
    


}


extension SubscribeListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.identifier) as? CustomCell ?? CustomCell()
        cell.bind(model: data[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}
