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

    let stackView = UIStackView().then {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 20
        $0.distribution = .equalSpacing
        $0.backgroundColor = .systemBackground
        $0.layer.cornerRadius = 10
    }
    
    let littleTitleLabel = UILabel().then{
        $0.text = "Acount"
        $0.font = UIFont(name: "Avenir-Black", size: 15)
    }
        
    // for stackview
    let logOutBtn = UIButton().then {
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.setTitle("로그아웃", for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
//        $0.layer.borderWidth = 2
        $0.setTitleColor(.white, for: .normal)

    }
    
    let withdrawalBtn = UIButton().then {
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.setTitle("회원탈퇴", for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
//        $0.layer.borderWidth = 2
        $0.setTitleColor(.white, for: .normal)

    }

    let changeEmailBtn = UIButton().then {
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.setTitle("이메일 변경", for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
//        $0.layer.borderWidth = 2
        $0.setTitleColor(.white, for: .normal)

    }
    
    let changePasswordOutBtn = UIButton().then {
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.setTitle("비밀번호 변경", for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
//        $0.layer.borderWidth = 2
        $0.setTitleColor(.white, for: .normal)

    }
    
    let littleTitle2Label = UILabel().then{
        $0.text = "Setting"
        $0.font = UIFont(name: "Avenir-Black", size: 15)
    }
    
    let SubscriptionNotificationBtn = UIButton().then {
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.setTitle("구독 알림", for: .normal)
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
        $0.layer.borderWidth = 2
        $0.setTitleColor(.white, for: .normal)

    }
    
    let switchforSubscription = UISwitch().then{

        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.onTintColor = UIColor.customColor(.defaultBlackColor)
//        $0.onTintColor = UIColor.customColor(.defaultBackgroundColor)

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
        setUI()
    }
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(littleTitleLabel)
        view.addSubview(stackView)
        view.addSubview(littleTitle2Label)
        view.addSubview(SubscriptionNotificationBtn)
        SubscriptionNotificationBtn.addSubview(switchforSubscription)
        
        self.stackView.addArrangedSubviews([logOutBtn,withdrawalBtn])
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(90)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-100)
        }
        
        littleTitleLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(littleTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        littleTitle2Label.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(30)
        }

        SubscriptionNotificationBtn.snp.makeConstraints{
            $0.top.equalTo(littleTitle2Label.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }

        switchforSubscription.snp.makeConstraints{
            $0.top.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
            $0.trailing.equalToSuperview().offset(-10)

        }
    }
    
}





