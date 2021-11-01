//
//  String+Extension.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/02.
//

import Foundation

extension String {
    
    func localized(tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: .main, value: "", comment: "")
    }
}
