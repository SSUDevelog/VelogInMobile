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
import Kingfisher

class PostCell: UITableViewCell {
    
    
    
    static let identifier = "PostCell"
    
    var imgView: UIImageView = {
        let view = UIImageView()
        let url = URL(string: "https://velog.velcdn.com/images/lms7802/post/7defe4e7-7259-4c9b-801c-bea50c1e68b9/image.png")
//        view.image = UIImage(systemName: "pencil")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.kf.setImage(with: url)
        view.snp.makeConstraints { make in
            make.height.equalTo(150)
        }
        return view
    }()
    
    var textView :UITextView = {
        let textView = UITextView()
        textView.textColor = UIColor.darkGray
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        return textView
    }()
    
    var title = UILabel().then{
        $0.font = UIFont(name: "Avenir-Black", size: 15)
    }
    
    var date = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13)
    }
    var name = UILabel().then{
        $0.font = UIFont(name: "Avenir-Black", size: 13)
    }

    lazy var UserAndDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [name,date])
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        return stackView
    }()
    
    lazy var GlobalstackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imgView,UserAndDateStackView,title,textView])
        stackView.spacing = 5
//        stackView.backgroundColor = .blue
        stackView.alignment = .fill
        stackView.distribution = .fill
//        stackView.distribution = .fillProportionally // 이걸로 하면 다 나온다... 왜지
        stackView.axis = .vertical
        contentView.addSubview(stackView)
//
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
        let attributedString = NSMutableAttributedString(string: model.summary)
        textView.attributedText = attributedString
        
        name.text = model.name
        date.text = model.date
//        imgView.image = model.img
        print("binding")
    }
}
