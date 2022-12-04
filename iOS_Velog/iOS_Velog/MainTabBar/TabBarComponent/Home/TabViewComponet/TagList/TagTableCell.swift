//
//  TagTableCell.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/12/02.
//

import Foundation
import UIKit
import SnapKit


class TagTableCell:UITableViewCell {
    // id 정의
    static let identifier = "TagTableCell"
    
    var leftLabel:UILabel = {
        let label = UILabel()
        label.tintColor = UIColor.customColor(.defaultBlackColor)
        return label
    }()

    
    // 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 어떻게 이 코드가.... 뭐지..
//        print(stackView)
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



extension TagTableCell {
    public func bindForTag(model: String) {
        leftLabel.text = model
    }
}
