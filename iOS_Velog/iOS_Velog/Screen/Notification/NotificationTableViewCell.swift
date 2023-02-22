//
//  NotificationTableViewCell.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/22.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    // id 정의
    static let identifier = "NotificationTableViewCell"
    
    var title:UILabel = {
        let label = UILabel()
        label.tintColor = UIColor.customColor(.defaultBlackColor)
        return label
    }()
    
    var textView:UITextView = {
        let textView = UITextView()
        textView.tintColor = UIColor.gray
        return textView
    }()
    
//    var link: String = ""
    

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title,textView])
        stackView.spacing = 10
        stackView.axis = .vertical
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints{
            $0.top.left.bottom.right.equalTo(contentView)
        }
        return stackView
    }()
    
    
    // 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 어떻게 이 코드가.... 뭐지..
        print(stackView)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }
    
}



extension NotificationTableViewCell {
    public func bindForNotification(title:String,body:String) {
        self.title.text = title
        self.textView.text = body
    }
}
