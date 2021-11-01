//
//  UIImageView+Extension.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/11/01.
//

import Foundation
import UIKit.UIImageView

extension UIImageView {
    
    func topImageViewSetting() {
        
        self.image = UIImage(named: "A Tale Dark & Grimm")
        self.contentMode = .scaleAspectFill
        
    }
    
    func posterImageViewSetting() {
        
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
}
