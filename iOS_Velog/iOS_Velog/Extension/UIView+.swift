//
//  UIView+.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/11.
//

import Foundation
import UIKit.UIView

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}




