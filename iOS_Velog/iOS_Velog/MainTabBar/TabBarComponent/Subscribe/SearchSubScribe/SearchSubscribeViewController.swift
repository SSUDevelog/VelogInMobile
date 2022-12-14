//
//  SearchSubscribeViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/26.
//

import UIKit
import SnapKit
import Then
import Moya

class SearchSubscribeViewController: UIViewController, UITextFieldDelegate{

    // for server
    private let provider = MoyaProvider<SubscriberService>()
    var responseData: AddSubscriberResponse?
    
    // prevent UIButton double touch
    var preventButtonTouch = false
    
    let titleLabel = UILabel().then {
        $0.text = "Add Your Subscribers"
        $0.font = UIFont(name: "Avenir-Black", size: 20)
    }
    
    let AddSubscriberBtn = UIButton().then {
        $0.setTitle("구독 추가", for: .normal)
        $0.setTitleColor(UIColor.customColor(.defaultBackgroundColor), for: .normal)
        $0.layer.cornerRadius = 4
        $0.backgroundColor = UIColor.customColor(.pointColor)
        $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        $0.addTarget(self, action: #selector(onTouchedButton), for: .touchDown)
    }
    
    let textField = UITextField().then{
        $0.placeholder = "velog 아이디를 입력해주세요."
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
    }
    
    let label = UILabel().then{
        $0.text = ""
        $0.textColor = UIColor.red
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
    }


    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.textField.delegate = self  // 필요??
        
        self.dismissKeyboard()
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        // UI
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    func setUI(){
        
        setTextField()
        
        view.backgroundColor = .systemBackground

        view.addSubviews(titleLabel)
        view.addSubviews(textField)
        view.addSubviews(label)
        view.addSubviews(AddSubscriberBtn)
        
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(41)
            make.trailing.equalToSuperview().offset(-47)
        }
        
        label.snp.makeConstraints{ make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.leading.equalTo(textField.snp.leading)
        }
        
        AddSubscriberBtn.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(50)
            make.leading.equalTo(textField.snp.leading)
            make.trailing.equalTo(textField.snp.trailing)
        }

        
    }

    func setTextField(){
        self.textField.autocapitalizationType = .none
        self.textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.textField.clearButtonMode = .always
    }
    
    // prevent UIButton double touch
    @objc func onTouchedButton(){
        
        if preventButtonTouch == true {
            return
        }
        
        preventButtonTouch = true
        // do Something
        self.checkVelogUser()
        // Method body ends
        preventButtonTouch = false
        
    }
    
    // velog 유저 체크 시작점
    func checkVelogUser(){
        let id = self.textField.text ?? ""
        print(id)
        postServer(id: id)
    }
    
    // 검색 결과 확인
    func postServer(id:String){
        self.provider.request(.checkSubscriber(self.textField.text ?? "")){ response in
        switch response{
            case .success(let moyaResponse):
                do{
                    
                    print(try moyaResponse.mapJSON())
                    let responseData = try moyaResponse.map(AddSubscriberResponse.self)
                    
                    print(responseData.userName as Any)

                    if self.checkDoubleSubscription(inputId: responseData.userName) == false {
                        self.label.text = "이미 구독한 유저입니다."
                        self.label.textColor = .red
                        self.delayWithSeconds(1) {
                            self.label.text = ""
//                            self.textField.text = ""
                        }
                    }else if responseData.validate == true {
                        print("구독자 추가 성공!")
                        self.label.textColor = UIColor.customColor(.pointColor)
                        self.label.text = "구독 추가 되었습니다."
                        self.delayWithSeconds(1) {
                            self.label.text = ""
//                            self.textField.text = ""
                            self.label.textColor = .red
                        }
                        // 최종 구독자 추가
                        self.addSubscriber(Id: id)
                    }else {
                        print("없는 사용자입니다.")
                        self.label.text = "없는 사용자입니다."
                        self.delayWithSeconds(1) {
                            self.label.text = ""
//                            self.textField.text = ""
                        }
                    }
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // 시간 딜레이 함수
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    // 구독자 최종 추가
    func addSubscriber(Id:String){
        let param = AddRequest(SignInViewController.FcmToken, Id)
        self.provider.request(.addSubscriber(param: param)){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    print("최종추가됨")
                    
                    
                    self.getServer()
                    self.getPostDataServer()
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    
    
    // 구독자 추가했을 경우 서버 디비 재호출
    func getServer(){
        self.provider.request(.getSubscriber){response in
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
    
    // 구독하려는 아이디가 구독리스트에 있는지 체크하는 메소드
    func checkDoubleSubscription(inputId:String)->Bool{
        for list in userList.List {
            if list == inputId {
                return false
            }
        }
        return true
    }
    
    // 구독자 글 호출
    func getPostDataServer(){
        self.provider.request(.subscriberpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPost")
                    
                    print(moyaResponse.statusCode)
                    PostData.Post = try moyaResponse.map(PostList.self)
                    
                    self.resetURL(indexSize: PostData.Post.subscribePostDtoList.count)
                    
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
        
        for x in 0..<indexSize {
            print(urlList.list[x])
        }
        
    }
    
}
