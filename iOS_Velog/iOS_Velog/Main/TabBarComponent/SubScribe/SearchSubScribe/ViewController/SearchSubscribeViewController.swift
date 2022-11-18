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

    let titleLabel = UILabel().then {
        $0.text = "Search"
        $0.font = UIFont(name: "Avenir-Black", size: 40)
    }
    let titleLabel2 = UILabel().then {
        $0.text = "Subscriber"
        $0.font = UIFont(name: "Avenir-Black", size: 40)
    }
    
    let AddSubscriberBtn = UIButton().then {
        $0.setTitle("구독 추가", for: .normal)
        $0.setTitleColor(UIColor.customColor(.pointColor), for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.customColor(.defaultBlackColor)
        $0.addTarget(self, action: #selector(checkVelogUser), for: .touchDown)
    }
    
    let textField = UITextField().then{
        $0.placeholder = "velog 아이디를 입력해주세요."
    }
    
    let label = UILabel().then{
        $0.text = ""
        $0.textColor = UIColor.red
    }


    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.textField.delegate = self  // 필요??
        
        // UI
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getServer()
    }

    
    func setUI(){
        
        setTextField()
        
        view.backgroundColor = .systemBackground

        view.addSubviews(titleLabel)
        view.addSubviews(titleLabel2)
        view.addSubviews(textField)
        view.addSubviews(AddSubscriberBtn)
        view.addSubviews(label)
        
        
        titleLabel.snp.makeConstraints{
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
        }
        titleLabel2.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.centerX.equalTo(titleLabel)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel2.snp.bottom).offset(60)
            make.centerX.equalTo(titleLabel2)
        }
        
        label.snp.makeConstraints{ make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.centerX.equalTo(textField)
        }
        
        AddSubscriberBtn.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(90)
            make.leading.equalToSuperview().offset(90)
            make.trailing.equalToSuperview().offset(-90)
        }

        
    }

    func setTextField(){
        self.textField.autocapitalizationType = .none
        self.textField.borderStyle = UITextField.BorderStyle.roundedRect
        self.textField.clearButtonMode = .always
    }
    
    // velog 유저 체크 시작점
    @objc func checkVelogUser(){
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

                    if responseData.validate == true {
                        print("구독자 추가 성공!")
                        self.label.textColor = UIColor.black
                        self.label.text = "구독 추가 되었습니다."
                        // 최종 구독자 추가
                        self.addSubscriber(Id: id)
                    }else{
                        print("없는 사용자입니다.")
                        self.label.text = "없는 사용자입니다."
                        self.textField.text = ""
                    }
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // 구독자 최종 추가
    func addSubscriber(Id:String){
        let param = AddRequest("temporaryFCMToken", Id)
        self.provider.request(.addSubscriber(param: param)){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    print("최종추가됨")
                    
                    self.getServer()
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
}

