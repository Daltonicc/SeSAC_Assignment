//
//  LoginViewModel.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/03.
//

import Foundation

class LoginViewModel {
    
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postUserLogin(completion: @escaping () -> Void) {
        
        APIService.login(identifier: email.value, password: password.value) { userData, error in
            
            guard let userData = userData else {
                print("noUserData")
                return
            }
            print(userData)
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            
            completion()
        }
    }
}
