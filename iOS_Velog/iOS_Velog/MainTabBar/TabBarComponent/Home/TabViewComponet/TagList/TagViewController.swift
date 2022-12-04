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
//        tableview.backgroundColor = .blue
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        tableViewForTag.register(TagTableCell.self, forCellReuseIdentifier: TagTableCell.identifier)
        tableViewForTag.delegate = self
        tableViewForTag.dataSource = self
        
        
        
        
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetTagList()
    }
    
    func resetTagList(){
        tableViewForTag.reloadData()
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

extension TagViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTag.List.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TagTableCell.identifier) as? TagTableCell ?? TagTableCell()
        cell.bindForTag(model: userTag.List[indexPath.row])
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            tableView.beginUpdates()
            userTag.List.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
}
