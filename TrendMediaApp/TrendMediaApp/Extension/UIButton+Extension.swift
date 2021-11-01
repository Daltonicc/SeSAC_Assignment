//
//  UIButton+Extension.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/11/01.
//

import Foundation
import UIKit.UIButton

extension UIButton {
    
    func leftbuttonSetting() {
        
        self.setImage(UIImage(systemName: "film"), for: .normal)
        self.contentHorizontalAlignment = .fill
        self.contentVerticalAlignment = .fill
        self.tintColor = .systemGreen
        
    }
    
    func middleButtonSetting() {
        
        self.setImage(UIImage(systemName: "tv"), for: .normal)
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.tintColor = .systemOrange

    }
    
    func rightButtonSetting() {
        
        self.setImage(UIImage(systemName: "book.closed"), for: .normal)
        self.contentVerticalAlignment = .fill
        self.contentHorizontalAlignment = .fill
        self.tintColor = .systemBlue
        
    }
    
    func webButtonSetting() {
        
        self.setImage(UIImage(systemName: "paperclip"), for: .normal)
        self.backgroundColor = .white
        self.layer.cornerRadius = 15
        self.tintColor = .black
        
    }
}
