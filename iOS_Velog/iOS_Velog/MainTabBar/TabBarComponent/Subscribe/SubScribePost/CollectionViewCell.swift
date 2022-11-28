//
//  CollectionViewCell.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import UIKit
import SnapKit
import Then

class CustomCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CustomCollectionViewCell"
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "pencil")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
//    var memberNameLabel: UILabel!
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
         setUpCell()
//         setUpLabel()
     }
     
     override init(frame: CGRect) {
         super.init(frame: .zero)

         setUpCell()
//         setUpLabel()
        setTextView()
     }
         
    
    
    func setTextView(){
        let textForSummart = "경력을 시작한 지 2년 쯤 지날을 때, 팀장님이 질문했습니다. 함께 일하고 싶은 사람은 어떤 사람일까요? 괜찮은 대답을 하지 못 했습니다. 막연한 좋은 모습들 중 하나"
        let attributedString = NSMutableAttributedString(string: textForSummart)
        self.textView.attributedText = attributedString
        textView.textColor = UIColor.darkGray
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15)
//        textView.backgroundColor = .red
    }
    
     func setUpCell() {
         
//         contentView.backgroundColor = .systemRed
         
         contentView.addSubview(imageView)
         contentView.addSubview(title)
         contentView.addSubview(textView)
         contentView.addSubview(date)
         contentView.addSubview(name)
         contentView.clipsToBounds = true
         
    }
         
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.leading.equalToSuperview().offset(1)
            make.trailing.equalToSuperview().offset(-1)
            make.height.equalTo(100)
        }

        title.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
//            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview()
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-30)
            make.height.equalTo(80)
        }
        
        name.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().offset(-150)
        }
        
        date.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(5)
            make.leading.equalTo(name.snp.trailing)
            make.trailing.equalToSuperview().offset(-30)
        }
    }
    
    
    // 아래 함수들은 더미데이터 없앨때 쓰자!!!
//image:String, -> 일단 보류
    public func configure(title:String,textViewText:String,name:String,date:String){
        self.title.text = title
        self.textView.text = textViewText
        self.name.text = name
        self.date.text = date
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView = nil
//        title.text = nil
//        textView.text = nil
//        name.text = nil
//        date.text = nil
    }
}
