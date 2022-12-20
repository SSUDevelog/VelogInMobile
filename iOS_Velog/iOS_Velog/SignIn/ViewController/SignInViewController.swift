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

    static var FcmToken:String!
    static var ID:String!
    static var PW:String!
    
    // MoyaTarget과 상호작용하는 MoyaProvider를 생성하기 위해 MoyaProvider인스턴스 생성
    private let provider = MoyaProvider<SignServices>()
    private let providerForTag = MoyaProvider<TagService>()
    private let providerForSubscriber = MoyaProvider<SubscriberService>()
    private let concurrentQueue = DispatchQueue.init(label: "SignInView",attributes: .concurrent)
    
    // ResponseModel를 userData에 넣어주자!
    var userData: SignInModel?
    var responseData: SigninResponse?
    
    let realm = RealmService()
    
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.textColor = UIColor.customColor(.defaultBlackColor)
//        $0.text = "Login"
        label.font = UIFont(name: "Apple SD Gothic Neo", size: 25)
        return label
    }()
    
    let EmailTextField = UITextField().then{
        $0.placeholder = ("아이디(이메일)")
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        $0.layer.cornerRadius = 4
        $0.borderStyle = .roundedRect
    }
    let PasswordTextField = UITextField().then{
        $0.placeholder = ("비밀번호")
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 14)
        $0.layer.cornerRadius = 4
        $0.borderStyle = .roundedRect
    }
    
    let SignInButton = UIButton().then{
        $0.backgroundColor = UIColor.customColor(.pointColor)
        $0.layer.cornerRadius = 4
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 18)
        $0.addTarget(self, action: #selector(pushViewForSignIn), for: .touchUpInside)
    }
    
    let SignUpButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemBackground
        btn.setTitle("회원가입", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 13)
        btn.addTarget(self, action: #selector(pushViewForSignUp), for: .touchUpInside)
        return btn
    }()
    
    let GetIdPwButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .systemBackground
        btn.setTitle("아이디/비밀번호 찾기", for: .normal)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 13)
        return btn
    }()
    
    let stackView = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.spacing = 10
        $0.distribution = .equalSpacing
    }
    
    let stackViewForSignUpGet = UIStackView().then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .horizontal
        $0.alignment = .fill
        $0.spacing = 26
        $0.distribution = .equalSpacing
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        // Do any additional setup after loading the view.
        print("signIn")
        
//        realm.resetDB()
        
        self.dismissKeyboard()
        //         자동로그인 - 로컬에 토큰 있으면 자동 로그인 됨
        //         자동로그인 시 새로운 토큰 발급 받지 않는다
//        if checkRealmToken() {
//            ifSuccessPushHome()
//        }
//
        self.navigationItem.hidesBackButton = true
        
        setUIForSignIn()
    }


    func setUIForSignIn(){
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(SignInButton)
        view.addSubviews(stackViewForSignUpGet)
        self.stackView.addArrangedSubviews([EmailTextField,PasswordTextField])
        self.stackViewForSignUpGet.addArrangedSubviews([SignUpButton,GetIdPwButton])


        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(30)
//            $0.leading.equalToSuperview().offset(10)
//            $0.trailing.equalToSuperview().offset(-10)
            $0.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints{
            $0.centerX.equalToSuperview()
//            $0.top.equalTo(titleLabel.snp.bottom).offset(168)
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(80)
        }
        
        SignInButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(38)
            $0.trailing.equalToSuperview().offset(-37)
        }
        
        stackViewForSignUpGet.snp.makeConstraints {
            $0.top.equalTo(SignInButton.snp.bottom).offset(15)
            $0.leading.equalToSuperview().offset(94)
            $0.trailing.equalToSuperview().offset(-94)
            $0.bottom.equalToSuperview().offset(-340)
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
            postServer()
        default:
            ifSuccessPushHome()
        }
    }

    
    private func ifSuccessPushHome(){
        let nextVC = LoadingViewController()
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
    
    
    func postServer(){
        // server
        let param = SignInRequest.init("temporaryFCMToken", self.EmailTextField.text ?? "" ,self.PasswordTextField.text ?? "")
        print(param)
        self.provider.request(.signIn(param: param)){ response in
            switch response {
                case .success(let moyaResponse):
                    do {
                        print("post Server aa")
                        let responseData = try moyaResponse.map(SigninResponse.self)
                        // 로컬에 토큰 저장
                        self.addTokenInRealm(item: responseData.token)
                        print("ok you sign in")
                        self.realm.addProfile(ID: self.EmailTextField.text ?? "", PW: self.PasswordTextField.text ?? "")
                        print(self.realm.getProfileID(),self.realm.getProfilePW())
                        SignInViewController.ID = self.EmailTextField.text ?? ""
                        SignInViewController.PW = self.PasswordTextField.text ?? ""
                        self.ifSuccessPushHome()
                    } catch(let err) {
                        print(err.localizedDescription)
                        print("nonono")
                        self.showFailAlert()
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    print("nonono")
                    self.showFailAlert()
            }
        }
    }
    
    
    // Alert : 로그인 실패로 회원가입하라는 알림
    func showFailAlert(){
        
        let alert = UIAlertController(title: "로그인 실패", message: "이메일 또는 비밀번호를 확인해주세요.", preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "OK", style: .default, handler: { okAction in   // 여기에 클로저 형태로 이후 이벤트 구현
            
            // 텍스트 필드 초기화
//            self.EmailTextField.text = ""
//            self.PasswordTextField.text = ""
            
        })
    
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    

    
    
    func addTokenInRealm(item:String){
        // add token in realm
        realm.addToken(item: item)
    }
    
    func getServer(){
        self.providerForSubscriber.request(.getSubscriber){response in
            switch response{
            case .success(let moyaResponse):
                do{

                    print(moyaResponse.statusCode)
                    userList.List = try moyaResponse.mapJSON() as! [String]

                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func getServerTag(){
        self.providerForTag.request(.gettag){response in
            switch response{
            case .success(let moyaResponse):
                do{
//                    print(moyaResponse.statusCode)
                    print("getServerTag")
                    userTag.List = try moyaResponse.mapJSON() as! [String]  // 여기도 예외처리 필요
//                    print(userTag.List)
                    
                    DispatchQueue.main.async {
                        print("pushToHome")
//                        self.pushToHome()
                    }
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    func getPostDataServer(){
        self.providerForSubscriber.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPostDataServer")
                    
                    print(moyaResponse.statusCode)
                    PostData.Post = try moyaResponse.map(PostList.self)
                    
                    self.resetURL(indexSize: PostData.Post.subscribePostDtoList.count)
                    
//                    DispatchQueue.main.async {
//                        print("pushToHome")
//                        self.pushToHome()
//                    }
                    
                    print("성공")
                }catch(let err){
                    print(err.localizedDescription)
                    print("맵핑 안됨")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func resetURL(indexSize:Int){
        urlList.list.removeAll()
        for x in 0..<indexSize {
            urlList.list.append(PostData.Post.subscribePostDtoList[x].url)
        }
//        for x in 0..<indexSize {
//            print("UrlList")
//            print(urlList.list[x])
//        }
    }
    
    // 태그 맞춤 글 추천 아직 어디에 사용할 지 모름
    func getTagPostDataServer(){
        self.providerForTag.request(.tagpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPostTag in Singin")
                    print(moyaResponse.statusCode)
//                    TagPostData.Post = try moyaResponse.map(PostTagList.self)
                    TagPostData.Post = try moyaResponse.map(PostTagList.self)
                    self.resetTagURL(indexSize: TagPostData.Post.tagPostDtoList.count)
                    print("성공")
                }catch(let err){
                    print(err.localizedDescription)
                    print("맵핑 안됨")
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func resetTagURL(indexSize:Int){
        TagaUrlList.list.removeAll()
        for x in 0..<indexSize {
            TagaUrlList.list.append(TagPostData.Post.tagPostDtoList[x].url)
        }
//        for x in 0..<indexSize {
//            print("TagUrlList")
//            print(TagaUrlList.list[x])
//        }

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
