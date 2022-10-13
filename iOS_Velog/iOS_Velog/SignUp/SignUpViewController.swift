//
//  ViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/08.
//


import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController {
    
    // make components
    private let titleLabel = UILabel().then {
        $0.text = "Sign Up"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    private let labelForNameTextField = UILabel().then{
        $0.text = "Name"
        $0.font = UIFont(name: "Avenir-Black", size: 25)
    }
    private let labelForEmailTextField = UILabel().then{
        $0.text = "Email"
        $0.font = UIFont(name: "Avenir-Black", size: 25)
    }
    private let labelForIdTextField = UILabel().then{
        $0.text = "ID"
        $0.font = UIFont(name: "Avenir-Black", size: 25)
    }
    private let labelForPasswordTextField = UILabel().then{
        $0.text = "Password"
        $0.font = UIFont(name: "Avenir-Black", size: 25)
    }
    private let labelForCheckpasswordTextField = UILabel().then{
        $0.text = "Check password"
        $0.font = UIFont(name: "Avenir-Black", size: 25)
    }
    
    // width, height 의 의미가 있을까?
    let nameTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    let emailTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    let idTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    let passwordTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    let checkPasswordTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
    
    let stackView = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 10
        $0.distribution = .equalSpacing
    }
    
    let nextButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("Next", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    // funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        setUI()
    }
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        self.stackView.addArrangedSubviews([labelForNameTextField, nameTextField, labelForEmailTextField,emailTextField,labelForIdTextField,idTextField,labelForPasswordTextField,passwordTextField,labelForCheckpasswordTextField,checkPasswordTextField])
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(70)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-100)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        nextButton.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(50)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(250)
        }
        
    }

    @objc func pushView(){
        print("pushView")
        let nextVC = SearchKeywordViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

}
