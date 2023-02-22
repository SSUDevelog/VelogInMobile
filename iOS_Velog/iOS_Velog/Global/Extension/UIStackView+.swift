//
//  UIStackView+.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/10.
//

import Foundation
import UIKit.UIStackView

extension UIStackView {
    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
