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

class SignUpViewController: UIViewController,UITextFieldDelegate {

    // MoyaTarget과 상호작용하는 MoyaProvider를 생성하기 위해 MoyaProvider인스턴스 생성
    private let provider = MoyaProvider<SignServices>()
    // ResponseModel를 userData에 넣어주자!
    var userData: SignUpModel?

    // make components
    
    let maxLength:Int = 8


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
    /*let idTextField = UITextField.attributedTextField(frame: CGRect(x: 0, y: 0, width: 300, height: 40))*/
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
    
    private let warningLabelForPassword = UILabel().then {
        $0.font = UIFont(name: "Avenir-Black", size: 12)
        $0.text = "글자와 숫자를 섞어서 7글자 이상 15글자 이하로 입력해주세요."
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
        $0.addTarget(SignUpViewController.self, action: #selector(pushView), for: .touchUpInside)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDemailchange(_:)), name: UITextField.textDidChangeNotification, object: emailTextField)
        
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true  // for hideBackBtn in NavigationController
        setUI()
    }
    /*
    override func viewDid() {
        super.viewDemailLoad()
        print("viewDemailLoad")
        self.view.backgroundColor = .systemBackground

        nameTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(textDemailChange(_:)), name: UITextField.textDemailChangeNotification, object: emailTextField)
        
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true  // for hideBackBtn in NavigationController
        setUI()
    }*/
    
    
    func setUI(){
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(nextButton)
        
        self.stackViewForWarning.addArrangedSubviews([nameTextField,warningLabelForName])
        self.stackViewForEmail.addArrangedSubviews([labelForEmailTextField,emailTextField,warningLabelForEmail])
        self.stackViewForPassword.addArrangedSubviews([labelForPasswordTextField,passwordTextField,warningLabelForPassword])
        self.stackViewForCheckPassword.addArrangedSubviews([labelForCheckpasswordTextField,checkPasswordTextField])

        
        
        self.stackView.addArrangedSubviews([labelForNameTextField, stackViewForWarning,stackViewForEmail,stackViewForPassword,stackViewForCheckPassword])
        
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
        self.signUp()
        let nextVC = SearchKeywordViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func signUp(){
        // signUp에서는 param값을 사용하기 때문에 signUpRequest 모델에 맞게
        // 데이터들을 넣어줍니다.
        // signUpModel에서 요청하는 데이터인 name, email, id, password를 넣어줬어요.
        let param = SignUpRequest.init(self.nameTextField.text!, self.emailTextField.text!, self.passwordTextField.text!, self.checkPasswordTextField.text!)
        // !!! 여기 db 구조 클라랑 서버 다름 (role)
            print(param)
        // LoginServices enum값 중에서 .signUp를 골라서 param과 함께 request시켜줍니다.
        // 그에 대한 response가 돌아오면 해당 response가 .success이면 result값을
        // SignupModel에 맞게끔 가공해주고나서
        // 위에 선언해뒀던 SignupModel모습을 갖춘 userData에 넣어줍니다.
            provider.request(.signUp(param: param)) { response in
                switch response {
                    case .success(let result):
                        do {
                            self.userData = try result.map(SignUpModel.self)
                        } catch(let err) {
                            print(err.localizedDescription)
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                }
            }
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {return false}
        // 최대 글자수 이상을 입력한 이후에는 중간에 다른 글자를 추가할 수 없게끔 작동
        if text.count >= maxLength && range.length == 0 && range.location < maxLength {
            return false
        }
        
        return true
    } // 이 함수를 넣은 이유??
    
    // 아이디 검사
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
                        warningLabelForName.text = "사용 가능한 이름입니다."
                        warningLabelForName.textColor = .black
                    }
                }
            }
        }
    
    // 이메일 검사
    @objc private func textDemailchange(_ notification: Notification) {
        if let textField = notification.object as? UITextField {
            if let text = textField.text {
                

                if text.count < 1  {
                    warningLabelForEmail.text = "이메일을 입력해주세요."
                    warningLabelForEmail.textColor = .red
                }else{
                    if checkEmail(str: text) == false {
                        warningLabelForEmail.text = "올바르지 않은 이메일 형식입니다."
                        warningLabelForEmail.textColor = .red
                    }
                    else {
                        warningLabelForEmail.text = "올바른 이메일 형식입니다."
                        warningLabelForEmail.textColor = .black
                    }
                }
            }
        }
    }
    
    // 이메일 형식 검사 함수
    func checkEmail(str: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        print("check")
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: str)
    }
    
    
    
    
    
    // 비밀번호 검사
    /*
    @objc private func textDpwchange(_ notification: Notification) {
                if let textField = notification.object as? UITextField {
                    
                   // var n = 0
                    
                    //while n == 1 {
                        
                        // 글자수 체크
                        if let text = textField.text {
                            
                            if text.count > 16 {
                                // 16글자 넘어가면 자동으로 키보드 내려감
                                textField.resignFirstResponder()
                            }
                            
                            // 초과되는 텍스트 제거
                            if text.count >= 15 {
                                let index = text.index(text.startIndex, offsetBy: maxLength)
                                let newString = text[text.startIndex..<index]
                                textField.text = String(newString)
                            }
                            
                            else if text.count < 7 {
                                warningLabelForName.text = "7글자 이상 15글자 이하로 입력해주세요"
                                warningLabelForName.textColor = .red
                            }
                            else {
                                warningLabelForName.text = "사용 가능한 비밀번호입니다."
                                warningLabelForName.textColor = .black
                            }
                        }
                    //}
                }
            }
*/
        
  /*
        case minCount...maxCount:
            let idPattern = #"^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{\#(minCount),\#(maxCount)}$"#
            let isVaildPattern = (textDpwchange.text!.range(of: idPattern, options: .regularExpression) != nil)
            if isVaildPattern {
                passwordTextFieldDescription.text = "조건에 맞는 비밀번호"
                passwordTextFieldDescription.isHidden = true
            } else {
                passwordTextFieldDescription.text = "영어알파벳, 숫자, 특수문자가 필수로 입력되어야 합니다."
            }
        } */
    
    
}
