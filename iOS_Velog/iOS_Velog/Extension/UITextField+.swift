//
//  UITextField+.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/09.
//

import Foundation
import UIKit


extension UITextField {
    // frame 값 받는 의미가 있을까?
    class func attributedTextField(frame: CGRect) -> UITextField {
        let textField = UITextField(frame: frame)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 2
        textField.layer.masksToBounds = true

        // padding
        textField.leftView = UIView(frame: CGRect.init(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = UITextField.ViewMode.always
        textField.rightView = UIView(frame: CGRect.init(x: 0, y: 0, width: 25, height: 0))
        textField.rightViewMode = UITextField.ViewMode.always
        
        return textField
    }

}
