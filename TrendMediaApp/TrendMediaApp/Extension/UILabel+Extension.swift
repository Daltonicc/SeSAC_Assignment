//
//  UILabel+Extension.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/11/01.
//

import Foundation
import UIKit.UILabel

extension UILabel {
    
    func veryTopLabelSetting() {
        
        self.text = "OH PARK!"
        self.font = .boldSystemFont(ofSize: 40)
        self.textAlignment = .center
        self.textColor = .white
        self.adjustsFontSizeToFitWidth = true
        
    }
    
    func subRateLabelSetting() {
        
        self.text = "예상"
        self.textAlignment = .center
        self.backgroundColor = .orange
        
    }
    
    func rateLabelSetting() {
        
        self.textAlignment = .center
        self.backgroundColor = .white
        
    }
    
}
