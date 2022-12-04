//
//  customCell.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/11/04.
//

import Foundation
import UIKit
import SnapKit


class CustomCell:UITableViewCell{
    // id 정의
    static let identifier = "CustomCell"
    
    var leftLabel:UILabel = {
        let label = UILabel()
        label.tintColor = UIColor.customColor(.defaultBlackColor)
        return label
    }()
    
//    lazy var stackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [leftLabel])
//        stackView.spacing = 80
//        contentView.addSubview(stackView)
//
//        stackView.snp.makeConstraints{
//            $0.top.left.bottom.right.equalTo(contentView)
//        }
//        return stackView
//    }()
    
    
    // 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 어떻게 이 코드가.... 뭐지..
        contentView.addSubview(leftLabel)
        leftLabel.snp.makeConstraints { make in
            make.top.left.bottom.right.equalTo(contentView)
        }
        print(leftLabel)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been impl")
    }

    
}



extension CustomCell {
    public func bind(model: String) {
        leftLabel.text = model
    }
}
