//
//  AddTagViewController.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import UIKit

class AddTagViewController: UIViewController {

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
//        $0.addTarget(self, action: #selector(checkVelogUser), for: .touchDown)
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
    
}
