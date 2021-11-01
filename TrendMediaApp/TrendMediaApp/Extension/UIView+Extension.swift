//
//  UIView+Extension.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/11/01.
//

import Foundation
import UIKit.UIView

extension UIView {
    
    func showViewSetting() {
        
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(displayP3Red: 255/255, green: 222/255, blue: 222/255, alpha: 1.0)
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        
    }
    
    func topButtonViewSetting() {
        
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.layer.cornerRadius = 10
        
    }
    
}
