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
    
    var leftLabel:UILabel = {
        let label = UILabel()
        label.tintColor = UIColor.customColor(.defaultBlackColor)
        return label
    }()
    
    // 해당 알림 글로 넘어간다!
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBackground
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        return button
    }()

    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leftLabel, rightButton])
        stackView.spacing = 80
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
    public func bind(model: String) {
        leftLabel.text = model
    }
}
