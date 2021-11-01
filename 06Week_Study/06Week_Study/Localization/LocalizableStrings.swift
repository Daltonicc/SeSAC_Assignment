//
//  LocalizableStrings.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/02.
//

import Foundation

enum LocalizableSettings: String {
    
    case home_text
    
    
    var localized: String {
        return self.rawValue.localized()
    }
}
