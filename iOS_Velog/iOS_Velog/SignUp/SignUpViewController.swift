//
//  ViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/08.
//


import UIKit
import SnapKit
import Then

class SignUpViewController: UIViewController,UITextFieldDelegate {
    
    // make components
    
    let maxLength:Int = 5

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
    
    private let warningLabelForName = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.text = "2글자 이상 8글자 이하로 입력해주세요."
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }
    
    private let warningLabelForEmail = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.text = "이메일 형식에 맞춰주세요."
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }
    
    private let warningLabelForID = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.text = "2글자 이상 8글자 이하로 입력해주세요."
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }
    
    private let warningLabelForPassword = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.text = "글자와 숫자를 섞어서 2글자 이상 8글자 이하로 입력해주세요."
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }
    
    private let warningLabelForCheckPassword = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.text = "비밀번호를 다시 입력해주세요."
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }
    
    let nextButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("Next", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside)
    }
    
    
    let stackView = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 10
        $0.distribution = .equalSpacing
    }
    
    let stackViewForWarning = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 3
        $0.distribution = .equalSpacing
    }
    
    let stackViewForEmail = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 3
        $0.distribution = .equalSpacing
    }
    
    let stackViewForID = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 3
        $0.distribution = .equalSpacing
    }
    
    let stackViewForPassword = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 3
        $0.distribution = .equalSpacing
    }
    
    let stackViewForCheckPassword = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 3
        $0.distribution = .equalSpacing
    }
    
    
    
    
    // funcs
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.view.backgroundColor = .systemBackground

        nameTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nameTextField)
        
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true  // for hideBackBtn in NavigationController
        setUI()
    }
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        self.stackViewForWarning.addArrangedSubviews([nameTextField,warningLabelForName])
        self.stackViewForEmail.addArrangedSubviews([labelForEmailTextField,emailTextField])
        self.stackViewForID.addArrangedSubviews([labelForIdTextField,idTextField,warningLabelForID])
        self.stackViewForPassword.addArrangedSubviews([labelForPasswordTextField,passwordTextField,warningLabelForPassword])
        self.stackViewForCheckPassword.addArrangedSubviews([labelForCheckpasswordTextField,checkPasswordTextField])

        
        
        self.stackView.addArrangedSubviews([labelForNameTextField, stackViewForWarning,stackViewForEmail,stackViewForID,stackViewForPassword,stackViewForCheckPassword])
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(110)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-100)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        nextButton.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(60)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(30)
        }
        
    }

    @objc func pushView(){
        print("pushView")
        let nextVC = SearchKeywordViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        
        return true
    }
    
    @objc private func textDidChange(_ notification: Notification) {
            if let textField = notification.object as? UITextField {
                if let text = textField.text {
                    
                    if text.count > maxLength {
                        // 8글자 넘어가면 자동으로 키보드 내려감
                        textField.resignFirstResponder()
                    }
                    
                    // 초과되는 텍스트 제거
                    if text.count >= maxLength {
                        let index = text.index(text.startIndex, offsetBy: maxLength)
                        let newString = text[text.startIndex..<index]
                        textField.text = String(newString)
                    }
                    
                    else if text.count < 2 {
                        warningLabelForName.text = "2글자 이상 8글자 이하로 입력해주세요"
                        warningLabelForName.textColor = .red
                    }
                    else {
                        warningLabelForName.text = "사용 가능한 닉네임입니다."
                        warningLabelForName.textColor = .black
                    }
                }
            }
        }

}
