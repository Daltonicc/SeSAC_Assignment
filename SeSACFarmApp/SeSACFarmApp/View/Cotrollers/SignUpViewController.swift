//
//  SignUpViewController.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/02.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    let mainView = SignUpView()
    let viewModel = SignUpViewModel()
    
    override func loadView() {
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
        navigationItemConfig()
        textFieldConfig()
    }
    
    func navigationItemConfig() {
        
        navigationItem.title = "새싹농장 가입하기"
        navigationItem.leftBarButtonItem = mainView.backBarButton
        
        // 바버튼은 바로 addTarget해줄 수 없음. 쪼개줘야함.
        mainView.backBarButton.target = self
        mainView.backBarButton.action = #selector(backBarButtonClicked)
    }
    
    func textFieldConfig() {
        
        viewModel.email.bind { text in
    
            self.mainView.emailTextField.text = text
        }
        
        viewModel.username.bind { text in
            
            self.mainView.nicknameTextField.text = text
        }
    
        viewModel.password.bind { text in
            self.mainView.passwordTextField.text = text
        }
        
        mainView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(textField:)), for: .editingChanged)
        mainView.nicknameTextField.addTarget(self, action: #selector(nicknameTextFieldDidChange(textField:)), for: .editingChanged)
        mainView.passwordTextField.addTarget(self, action: #selector(passwordTextFieldDidChange(textField:)), for: .editingChanged)
        mainView.signUpButton.addTarget(self, action: #selector(signUpButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func emailTextFieldDidChange(textField: UITextField) {
        
        viewModel.email.value = textField.text ?? ""
    }
    
    @objc func nicknameTextFieldDidChange(textField: UITextField) {
        
        viewModel.username.value = textField.text ?? ""
    }

    @objc func passwordTextFieldDidChange(textField: UITextField) {
        
        viewModel.password.value = textField.text ?? ""
    }
    
    @objc func signUpButtonClicked() {
        
        viewModel.postUserSignUp {
            let vc = MainBoardViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    @objc func backBarButtonClicked() {
        
        navigationController?.popViewController(animated: true)
    }
    
}
