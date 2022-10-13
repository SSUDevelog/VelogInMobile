//
//  SIgnInViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//

import UIKit
import SnapKit
import Then

class SignInViewController: UIViewController {

    private let titleLabel = UILabel().then {
        $0.text = "Sign In"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let EmailTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    let passwordTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    
    let SignInButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("Enter", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushViewForSignIn), for: .touchUpInside)
    }
    
    let SignUpButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("SignUp", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushViewForSignUp), for: .touchUpInside)
    }
    
    let stackView = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 10
        $0.distribution = .equalSpacing
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        setUIForSignIn()
    }

    func setUIForSignIn(){
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        self.stackView.addArrangedSubviews([EmailTextField,passwordTextField,SignInButton,SignUpButton])
        EmailTextField.placeholder = "Give your email"
        passwordTextField.placeholder = "Give your password"
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(90)
            $0.trailing.equalToSuperview().offset(-90)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        
    }
    
    @objc func pushViewForSignUp(){
        print("pushView")
        let nextVC = SignUpViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    @objc func pushViewForSignIn(){
        // 일단 default 로그인 성공으로 가정
        print("pushView")
        let nextVC = CustomTabBarController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
