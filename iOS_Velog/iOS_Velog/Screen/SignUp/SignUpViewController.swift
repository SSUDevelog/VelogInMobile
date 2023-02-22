//
//  ViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/08.
//

import UIKit
import SnapKit
import Then
import Moya
import Foundation



class SignUpViewController: UIViewController,UITextFieldDelegate {

    // MoyaTarget과 상호작용하는 MoyaProvider를 생성하기 위해 MoyaProvider인스턴스 생성
    private let provider = MoyaProvider<SignServices>()
    // ResponseModel를 userData에 넣어주자!
    var userData: SignUpModel?
    var responseData : SignUpResponse?
    var password: String?
    
    var isAllTrue = [false,false,false,false]

    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.textColor = UIColor.customColor(.defaultBlackColor)
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 25)
        return label
    }()
    
    private let labelForNameTextField = UILabel().then{
        $0.text = "﹒이름"
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 13)
        $0.textColor = UIColor.gray
    }
    private let labelForEmailTextField = UILabel().then{
        $0.text = "﹒아이디(이메일)"
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 13)
        $0.textColor = UIColor.gray
    }
    private let labelForPasswordTextField = UILabel().then{
        $0.text = "﹒비밀번호"
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 13)
        $0.textColor = UIColor.gray
    }
    private let labelForCheckpasswordTextField = UILabel().then{
        $0.text = "﹒비밀번호 확인"
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 13)
        $0.textColor = UIColor.gray
    }

    let nameTextField = UITextField().then{
        $0.placeholder = ("이름")
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        $0.layer.cornerRadius = 4
        $0.borderStyle = .roundedRect
    }
    
    let emailTextField = UITextField().then{
        $0.placeholder = ("아이디(이메일)")
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        $0.layer.cornerRadius = 4
        $0.borderStyle = .roundedRect
    }
    
    let passwordTextField = UITextField().then{
        $0.placeholder = ("비밀번호")
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        $0.layer.cornerRadius = 4
        $0.borderStyle = .roundedRect
    }
    
    let checkPasswordTextField = UITextField().then{
        $0.placeholder = ("비밀번호 확인")
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        $0.layer.cornerRadius = 4
        $0.borderStyle = .roundedRect
    }
    
    
    
    private let warningLabelForName = UILabel().then {
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 10)
        $0.text = ""
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }

    private let warningLabelForEmail = UILabel().then {
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 10)
        $0.text = ""
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }

    private let warningLabelForPassword = UILabel().then {
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 10)
        $0.text = ""
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }

    private let warningLabelForCheckPassword = UILabel().then {
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 10)
        $0.text = ""
        $0.textColor = UIColor.customColor(.defaultBlackColor)
    }

    let nextButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.pointColor)
        $0.layer.cornerRadius = 4
        $0.setTitle("완료", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        $0.addTarget(self, action: #selector(pushView), for: .touchUpInside) // addTarget(SignUpViewController.self -> 때문에 "unrecognized selector sent to class" 에러 뜸
    }


    let stackView = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 24
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

        self.dismissKeyboard()
        
        
//        nameTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(_:)), name: UITextField.textDidChangeNotification, object: nameTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(textDemailchange(_:)), name: UITextField.textDidChangeNotification, object: emailTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(passwordChange(_:)), name: UITextField.textDidChangeNotification, object: passwordTextField)
        NotificationCenter.default.addObserver(self, selector: #selector(checkPasswordChange(_:)), name: UITextField.textDidChangeNotification, object: checkPasswordTextField)

        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true  // for hideBackBtn in NavigationController

        setUI()
    }

    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)

        self.stackViewForWarning.addArrangedSubviews([labelForNameTextField,nameTextField,warningLabelForName])
        self.stackViewForEmail.addArrangedSubviews([labelForEmailTextField,emailTextField,warningLabelForEmail])
        self.stackViewForPassword.addArrangedSubviews([labelForPasswordTextField,passwordTextField,warningLabelForPassword])
//        self.stackViewForPassword.addArrangedSubviews([labelForPasswordTextField,passwordTextField])
        self.stackViewForCheckPassword.addArrangedSubviews([labelForCheckpasswordTextField,checkPasswordTextField,warningLabelForCheckPassword])



        self.stackView.addArrangedSubviews([ stackViewForWarning,stackViewForEmail,stackViewForPassword,stackViewForCheckPassword])

        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(87)
            $0.leading.equalToSuperview().offset(146)
            $0.trailing.equalToSuperview().offset(-146)
        }

        stackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(45)
            $0.leading.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-37)
        }

        nextButton.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(232)
            $0.leading.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-37)
            $0.bottom.equalToSuperview().offset(-36)

        }

    }
    
    func postServer(){
        // name : id , pw : pw
        let param = SignUpRequest.init(self.emailTextField.text!, self.nameTextField.text!, self.passwordTextField.text!, self.checkPasswordTextField.text!)
        print(param)
        provider.request(.signUp(param: param)) { response in
                switch response {
                case .success(let moyaResponse):
                        do {
                            self.responseData = try moyaResponse.map(SignUpResponse.self)
                            print(moyaResponse.statusCode)
                        } catch(let err) {
                            print(err.localizedDescription)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                }
            }
    }

    // 아이디 검사
    @objc private func textDidChange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                
                if text.count < 2 {
                    warningLabelForName.text = "2글자 이상 8글자 이하로 입력해주세요"
                    warningLabelForName.textColor = .red
                    self.isAllTrue[0] = false
                }else if text.count > 8 {
                    warningLabelForName.text = "2글자 이상 8글자 이하로 입력해주세요"
                    warningLabelForName.textColor = .red
                    self.isAllTrue[0] = false
                }else {
                    warningLabelForName.text = "사용 가능한 이름입니다."
                    warningLabelForName.textColor = UIColor.customColor(.pointColor)
                    self.isAllTrue[0] = true
                }
            }
        }
    }

//     이메일 검사
    @objc private func textDemailchange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count < 1  {
                    warningLabelForEmail.text = "이메일을 입력해주세요."
                    warningLabelForEmail.textColor = .red
                    self.isAllTrue[1] = false
                }else{
                    if checkEmail(str: text) == false {
                        warningLabelForEmail.text = "올바르지 않은 이메일 형식입니다."
                        warningLabelForEmail.textColor = .red
                        self.isAllTrue[1] = false
                    }
                    else {
                        warningLabelForEmail.text = "올바른 이메일 형식입니다."
                        warningLabelForEmail.textColor = UIColor.customColor(.pointColor)
                        self.isAllTrue[1] = true
                    }
                }
            }
        }
    }

    // 이메일 형식 검사 함수
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
//        print("check")
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    @objc private func passwordChange(_ notification: Notification){
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text.count < 7 {
                    warningLabelForPassword.text = "7글자 이상 15글자 이하로 입력해주세요."
                    warningLabelForPassword.textColor = .red
                    self.isAllTrue[2] = false
                }else if text.count > 15 {
                    warningLabelForPassword.text = "7글자 이상 15글자 이하로 입력해주세요."
                    warningLabelForPassword.textColor = .red
                    self.isAllTrue[2] = false
                } else {
                    warningLabelForPassword.text = "사용가능한 비밀번호입니다."
                    warningLabelForPassword.textColor = UIColor.customColor(.pointColor)
                    self.password = text
                    self.isAllTrue[2] = true
                }
            }
        }
    }
    
    @objc private func checkPasswordChange(_ notification: Notification){
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                if text != self.password {
                    warningLabelForCheckPassword.text = "비밀번호가 동일하지 않습니다."
                    warningLabelForCheckPassword.textColor = .red
                    self.isAllTrue[3] = false
                } else {
                    warningLabelForCheckPassword.text = "비밀번호가 동일합니다."
                    warningLabelForCheckPassword.textColor = UIColor.customColor(.pointColor)
                    self.isAllTrue[3] = true
                }
            }
        }
    }
    
    // 완료 버튼 이벤트
    @objc func pushView(){
        // 4가지 형식 검사 통과했는지 검사
        for i in 0...3 {
            if isAllTrue[i] == true {
                continue
            }else{
                let alert = UIAlertController(title: "형식을 맞춰주세요.", message: "", preferredStyle: UIAlertController.Style.alert)
                let okAction = UIAlertAction(title: "예", style: .default, handler: { okAction in
                    // 여기에 클로저 형태로 이후 이벤트 구현
                })
                alert.addAction(okAction)
                present(alert, animated: true, completion: nil)
                return
            }
        }
        self.postServer()
        let nextVC = SignInViewController()
        let alert = UIAlertController(title: "회원가입 성공", message: "로그인 화면에서 로그인해주세요.", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "예", style: .default, handler: { okAction in
            // 여기에 클로저 형태로 이후 이벤트 구현
            self.navigationController?.pushViewController(nextVC, animated: true)
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
//        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
