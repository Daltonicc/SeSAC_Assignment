//
//  ViewController.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/01.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    override func loadView() {
        
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        buttonConfig()
        
    }

    func buttonConfig() {
        
        mainView.startButton.addTarget(self, action: #selector(startButtonClicked), for: .touchUpInside)
        mainView.loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func startButtonClicked() {
        
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func loginButtonClicked() {
        
        let vc = LoginViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true, completion: nil)
    }
}


/*
 구현해야 할 것
 1. 올바른 이메일 형식 얼럿
 2. 보드 로딩할 때 스켈레톤 뷰
 */
