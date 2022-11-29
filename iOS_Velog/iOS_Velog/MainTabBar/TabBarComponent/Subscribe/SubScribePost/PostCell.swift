//
//  TableViewForPosts.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/29.
//

import Foundation
import UIKit
import SnapKit
import Then

class PostCell: UITableViewCell {
    
    static let identifier = "PostCell"
    
    var imgView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "pencil")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    
    var textView = UITextView().then{
        $0.textColor = UIColor.darkGray
        $0.isEditable = false
        $0.isSelectable = false
        $0.isScrollEnabled = false
        $0.font = UIFont.systemFont(ofSize: 15)
    }
    var title = UILabel().then{
//        $0.text = "함께 일하고 싶은 사람"
        $0.font = UIFont(name: "Avenir-Black", size: 15)
    }
    
    var date = UILabel().then {
//        $0.text = "2022년 11월 9월"
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var name = UILabel().then{
//        $0.text = "city7310"
        $0.font = UIFont(name: "Avenir-Black", size: 13)
    }
    
    func setTextViewText(text:String){
        let attributedString = NSMutableAttributedString(string: text)
        self.textView.attributedText = attributedString
    }
    
    
    lazy var UserAndDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,date])
        stackView.spacing = 10
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints{
            $0.top.left.bottom.right.equalTo(contentView)
        }
        return stackView
    }()
    
    lazy var GlobalstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView,UserAndDateStackView,title,textView])
        stackView.spacing = 10
        stackView.axis = .vertical
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints{
            $0.top.left.bottom.right.equalTo(contentView)
        }
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 어떻게 이 코드가.... 뭐지..
        print(GlobalstackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
}

extension PostCell {
    public func binding(model:SubscribePostDtoList){
        title.text = model.title
        self.setTextViewText(text: model.summary)
        name.text = model.name
        date.text = model.date
//        imgView.image = model.img
    }
}
