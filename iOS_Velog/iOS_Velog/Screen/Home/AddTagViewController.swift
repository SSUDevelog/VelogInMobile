//
//  AddTagViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2023/02/22.
//

import UIKit
import SnapKit
import Then
import Moya

class AddTagViewController: UIViewController {
    
    // for server
    private let provider = MoyaProvider<TagService>()
    
    // prevent UIButton double touch
    var preventButtonTouch = false
    

    let titleLabel = UILabel().then {
        $0.text = "Add Your Keywords"
        $0.font = UIFont(name: "Avenir-Black", size: 20)
    }
    
    let AddTagBtn = UIButton().then {
        $0.setTitle("키워드 추가", for: .normal)
        $0.setTitleColor(UIColor.customColor(.defaultBackgroundColor), for: .normal)
        $0.layer.cornerRadius = 4
        $0.titleLabel?.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
        $0.backgroundColor = UIColor.customColor(.pointColor)
        $0.addTarget(self, action: #selector(onTouchedButton), for: .touchDown)
    }
    
    let textField = UITextField().then{
        $0.placeholder = "키워드를 입력해주세요."
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
    }
    
    let label = UILabel().then{
        $0.text = ""
        $0.textColor = UIColor.red
        $0.font = UIFont(name: "Apple SD Gothic Neo", size: 16)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.dismissKeyboard()
        
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.topItem?.title = ""
        
        setUI()
    }
    
    func setUI(){
        
        setTextField()
        
        view.backgroundColor = .systemBackground

        view.addSubviews(titleLabel)
        view.addSubviews(textField)
        view.addSubviews(label)
        view.addSubviews(AddTagBtn)
        
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
        
        AddTagBtn.snp.makeConstraints { make in
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
    
    // 시간 딜레이 함수
    func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
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
                    
                    self.delayWithSeconds(1) {
                        self.label.text = ""
                        self.label.textColor = UIColor.red
                    }
                    
                    self.getServerTag()
                    self.getTagPostDataServer()
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
    
    // 태그 맞춤 글 추천 아직 어디에 사용할 지 모름, 이런
    func getTagPostDataServer(){
        self.provider.request(.tagpost){ response in
            switch response{
            case .success(let moyaResponse):
                do{
                    print("getPostTag")
                    print(moyaResponse.statusCode)
                    TagPostData.Post = try moyaResponse.map(PostTagList.self)
                    // for test
                    print(TagPostData.Post.tagPostDtoList.count)
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
    }

}
