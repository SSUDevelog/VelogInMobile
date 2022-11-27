//
//  SIgnInViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/13.
//

import UIKit
import SnapKit
import Then
import Moya
import Realm
import RealmSwift


class SignInViewController: UIViewController {
    
    
    
    // MoyaTarget과 상호작용하는 MoyaProvider를 생성하기 위해 MoyaProvider인스턴스 생성
    private let provider = MoyaProvider<SignServices>()
    // ResponseModel를 userData에 넣어주자!
    var userData: SignInModel?
    var responseData: SigninResponse?
    
    let realm = RealmService()
    
    
    private let titleLabel = UILabel().then {
        $0.text = "Login"
        $0.font = UIFont(name: "Avenir-Black", size: 50)
    }
    
    let EmailTextField = UITextField().then{
        $0.placeholder = ("Email")
        $0.layer.cornerRadius = 10
        $0.borderStyle = .roundedRect
    }
    let PasswordTextField = UITextField().then{
        $0.placeholder = ("Password")
        $0.layer.cornerRadius = 10
        $0.borderStyle = .roundedRect
    }
    
    let SignInButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("Login", for: .normal)
        // $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushViewForSignIn), for: .touchUpInside)
    }
    
    let SignUpButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.layer.cornerRadius = 10
        $0.setTitle("For Sign Up", for: .normal)
        $0.setTitleColor(.systemBackground, for: .normal)
        $0.addTarget(self, action: #selector(pushViewForSignUp), for: .touchUpInside)
    }
    
    let stackView = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 20
        $0.distribution = .equalSpacing
    }
    
    let stackView2 = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 20
        $0.distribution = .equalSpacing
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        
//        realm.resetDB()
        
        // 자동로그인 - 로컬에 토큰 있으면 자동 로그인 됨
        // 자동로그인 시 새로운 토큰 발급 받지 않는다
        if checkRealmToken() {
//            pushViewForSignIn()
            ifSuccessPushHome()
        }
  
        
        setUIForSignIn()
//        print("viewDidLoad")
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        print("viewWillAppear")
//    }
    // Alert 꺼져도 view가 새로 뜨는 건 아니네!
    
    

    func setUIForSignIn(){
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(stackView2)
        self.stackView.addArrangedSubviews([EmailTextField,PasswordTextField])
        self.stackView2.addArrangedSubviews([SignInButton,SignUpButton])


        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(200)
            $0.leading.equalToSuperview().offset(130)
            $0.trailing.equalToSuperview().offset(-100)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        stackView2.snp.makeConstraints{
            $0.top.equalTo(stackView.snp.bottom).offset(100)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.equalToSuperview().offset(-30)
        }
        
        
    }
    
    @objc func pushViewForSignUp(){
        let nextVC = SignUpViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    

    @objc func pushViewForSignIn(){
        switch checkRealmToken() {
        case false :   // 토근 발급 전
            // 서버 통신
            print("no token")
            let successInt = postServer()
            if successInt > 200 {
                // 잘못된 접근
                showFailAlert()
                break
            }
            else{
                // 올바른 접근
                ifSuccessPushHome()
                break
            }
        default:
            ifSuccessPushHome()
        }
    }
    
    private func ifSuccessPushHome(){
        let nextVC = CustomTabBarController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // 로컬db에 토큰이 있는지 확인하는 함수
    func checkRealmToken()->Bool{
        if realm.getToken() == ""{
            return false
        }else{
            return true
        }
    }
    
    
    func postServer()->Int{
        var successInt = 499
        
        // server
        let param = SignInRequest.init("temporaryFCMToken", self.EmailTextField.text ?? "" ,self.PasswordTextField.text ?? "")
        print(param)
        self.provider.request(.signIn(param: param)){ response in
            switch response {
                case .success(let moyaResponse):
//                    var responseData = moyaResponse.data
                    do {
//                        print(moyaResponse.statusCode)
                        successInt =  moyaResponse.statusCode
//                        print(responseData.token)
                        let responseData = try moyaResponse.map(SigninResponse.self)
                        // 로컬에 토큰 저장
                        self.addTokenInRealm(item: responseData.token)
                        
                    } catch(let err) {
                        print(err.localizedDescription)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
            }
        }
        return successInt
    }
    
    
    // Alert : 로그인 실패로 회원가입하라는 알림
    func showFailAlert(){
        
        let alert = UIAlertController(title: "로그인 실패", message: "이메일 또는 비밀번호를 확인해주세요.", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { okAction in   // 여기에 클로저 형태로 이후 이벤트 구현
            
            // 텍스트 필드 초기화
            self.EmailTextField.text = ""
            self.PasswordTextField.text = ""
            
        })
    
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    

    
    
    func addTokenInRealm(item:String){
        // add token in realm
        realm.addToken(item: item)
    }
    
}

extension UIAlertAction {
    var titleTextColor: UIColor? {
        get {
            return self.value(forKey: "titleTextColor") as? UIColor
        } set {
            self.setValue(newValue, forKey: "titleTextColor")
        }
    }
}
