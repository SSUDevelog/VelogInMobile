//
//  UIColor+.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/10.
//

import Foundation
import UIKit

enum CustomColor {
    case defaultBackgroundColor
    case defaultBlackColor
    case pointColor
}

extension UIColor {
    
    static func customColor(_ color: CustomColor) -> UIColor {
           switch color {
           case .defaultBackgroundColor:
               return UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.0)
           case .defaultBlackColor:
               return UIColor(red: 0.204, green: 0.204, blue: 0.204, alpha: 1.0)
           case .pointColor:
               return UIColor(red: 0.118, green: 0.784, blue: 0.592, alpha: 1.0)
           }
    }
}
