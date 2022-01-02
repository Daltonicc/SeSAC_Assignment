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
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .white
        
        navigationItemConfig()
    }
    
    func navigationItemConfig() {
        
        navigationItem.title = "새싹농장 가입하기"
        navigationItem.leftBarButtonItem = mainView.backBarButton
        
        // 바버튼은 바로 addTarget해줄 수 없음. 쪼개줘야함.
        mainView.backBarButton.target = self
        mainView.backBarButton.action = #selector(backBarButtonClicked)
    }
    
    @objc func backBarButtonClicked() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
