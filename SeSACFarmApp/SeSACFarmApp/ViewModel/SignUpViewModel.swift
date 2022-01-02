//
//  SignUpViewModel.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/03.
//

import Foundation

class SignUpViewModel {
    
    var username: Observable<String> = Observable("")
    var email: Observable<String> = Observable("")
    var password: Observable<String> = Observable("")
    
    func postUserSignUp(completion: @escaping () -> Void) {
        
        APIService.signUp(username: username.value, email: email.value, password: password.value) { userData, error in
            
            guard let userData = userData else {
                return
            }
            print(userData)
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            
            completion()
        }
    }
}
