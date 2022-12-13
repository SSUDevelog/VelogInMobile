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
import Realm
import RealmSwift

class ProfileViewController: UIViewController {
    
    let realm = RealmService()
    
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
    
    // 알림 끄고 키는 함수
    func onOffAlert(){
        print("onOffAlert")
        
        let alert = UIAlertController(title: "알림 설정", message: "구독자 새 글 알림", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
        })
    
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    

    // 로그아웃 하는 함수
    func logOut(){
        print("logOut")
        
        let alert = UIAlertController(title: "로그아웃", message: "정말 로그아웃 하시겠습니까?", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "예", style: .destructive, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
            print("예")
            // 로컬 DB 초기화
            self.realm.resetDB()
            // 일단 보류...
            
            
//            self.realm.addToken(item: "")
//            self.realm.addProfile(ID: "", PW: "")
//            print(self.realm.getToken())
//            let nextVC = SignInViewController()
//            self.realm.resetDB()
//            self.navigationController?.pushViewController(nextVC, animated: true)
        })
        
        let noAction = UIAlertAction(title: "아니요", style: .default, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
        })
    
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // 회원탈퇴 하는 함수
    func MembershipOut(){
        print("Membership Out")
        
        let alert = UIAlertController(title: "회원탈퇴", message: "정말 탈퇴 하시겠습니까? 기존 정보가 사라집니다.", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "예", style: .destructive, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
            print("예")
        })
        
        let noAction = UIAlertAction(title: "아니요", style: .default, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
            print("아니요")
        })
    
        alert.addAction(okAction)
        alert.addAction(noAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

extension ProfileViewController: UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "sectionTableViewCell", for: indexPath)
        cell.selectionStyle = .none
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

extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath)
        switch indexPath.row {
        case 0:
            self.onOffAlert()
        case 1:
            self.logOut()
        case 2:
            self.MembershipOut()
        default: break
        }
    }
}

