//
//  TopView.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/18.
//

import UIKit
import SnapKit
import Then


class PostView: UIView {
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "pencil")
        view.contentMode = .scaleToFill
        return view
    }()
    
    var textView = UITextView()
    
    var title = UILabel().then{
        $0.text = "함께 일하고 싶은 사람"
//        $0.textColor = UIColor.gray
        $0.font = UIFont(name: "Avenir-Black", size: 15)
    }
    
    var date = UILabel().then {
        $0.text = "2022년 11월 9월"
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    
    var name = UILabel().then{
        $0.text = "city7310"
        $0.font = UIFont(name: "Avenir-Black", size: 15)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
       
    override init(frame: CGRect) {
        super .init(frame: .zero)
        setTextView()
        setViewHierarchy()
        setConstraints()

    }
    
    
    func setTextView(){
        let textForSummart = "경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나"
        let attributedString = NSMutableAttributedString(string: textForSummart)
        self.textView.attributedText = attributedString
        textView.textColor = UIColor.darkGray
        textView.isEditable = false
        textView.isSelectable = false
        textView.font = UIFont.systemFont(ofSize: 15)
    }
    
    func setViewHierarchy(){
        addSubview(imageView)
        addSubview(title)
        addSubview(textView)
        addSubview(date)
        addSubview(name)
        
    }
    
    func setConstraints(){

        imageView.snp.makeConstraints{

            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        title.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(40)
//            $0.width.equalTo(300)
            $0.trailing.equalToSuperview()
            
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(title.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(300)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(80)
        }
        
        date.snp.makeConstraints{
            $0.top.equalTo(textView.snp.bottom)
            $0.leading.equalToSuperview().offset(40)
            $0.trailing.equalToSuperview().offset(-100)
        }
        
        name.snp.makeConstraints{
            $0.top.equalTo(textView.snp.bottom)
            $0.trailing.equalToSuperview().offset(-30)
            $0.leading.equalToSuperview().offset(200)
            
        }
    }
}
