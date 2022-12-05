//
//  AddTagViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import UIKit
import SnapKit
import Then
import Moya

class AddTagViewController: UIViewController {
    
    // for server
    private let provider = MoyaProvider<TagService>()
//    var responseData
    
    // prevent UIButton double touch
    var preventButtonTouch = false
    

    let titleLabel = UILabel().then {
        $0.text = "Add"
        $0.font = UIFont(name: "Avenir-Black", size: 40)
    }
    let titleLabel2 = UILabel().then {
        $0.text = "New Keyword"
        $0.font = UIFont(name: "Avenir-Black", size: 40)
    }
    
    let AddTagBtn = UIButton().then {
        $0.setTitle("키워드 추가", for: .normal)
        $0.setTitleColor(UIColor.customColor(.defaultBackgroundColor), for: .normal)
        $0.layer.cornerRadius = 10
        $0.backgroundColor = UIColor.customColor(.pointColor)
        $0.addTarget(self, action: #selector(onTouchedButton), for: .touchDown)
    }
    
    let textField = UITextField().then{
        $0.placeholder = "키워드를 입력해주세요."
    }
    
    let label = UILabel().then{
        $0.text = ""
        $0.textColor = UIColor.red
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        setUI()
    }
    
    func setUI(){
        
        setTextField()
        
        view.backgroundColor = .systemBackground

        view.addSubviews(titleLabel)
        view.addSubviews(titleLabel2)
        view.addSubviews(textField)
        view.addSubviews(AddTagBtn)
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
        
        AddTagBtn.snp.makeConstraints { make in
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
    
    // prevent UIButton double touch
    @objc func onTouchedButton(){
        
        if preventButtonTouch == true {
            return
        }
        
        preventButtonTouch = true
        // do Something
        self.checkTag()
        // Method body ends
        preventButtonTouch = false
        
    }
    
    // tag 체크 시작점
    @objc func checkTag(){
        let tag = self.textField.text ?? ""
        print(tag)
        if checkDoubleTag(inputTag: tag) == false {
            self.label.text = "이미 추가한 키워드입니다."
            self.label.textColor = .red
            self.textField.text = ""
        }else {
            print("태그 리스트에 없는 태그")
            self.addTag(tag: tag)
        }
        
    }
    
    // 추가하려는 태그가 태그리스트에 있는지 체크하는 메소드
    func checkDoubleTag(inputTag:String)->Bool{
        for list in userTag.List {
            if list == inputTag {
                return false
            }
        }
        return true
    }
    
    // 태그 추가
    func addTag(tag:String){
        let param = AddTag(tag)
        self.provider.request(.addtag(param: param)){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    print("최종추가됨")
                    self.label.text = "키워드가 추가 되었습니다."
                    self.label.textColor = UIColor.customColor(.pointColor)
                    self.getServerTag()
                    
                }catch(let err){
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // 태그 추가했을 경우 서버 디비 재호출
    func getServerTag(){
        self.provider.request(.gettag){response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print(moyaResponse.statusCode)
                    userTag.List = try moyaResponse.mapJSON() as! [String]
                    print(userTag.List)
                }catch(let err) {
                    print(err.localizedDescription)
                }
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }

    
    
    
    
}
