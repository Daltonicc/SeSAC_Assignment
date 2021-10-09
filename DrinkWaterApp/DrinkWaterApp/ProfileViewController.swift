//
//  ProfileViewController.swift
//  DrinkWaterApp
//
//  Created by 박근보 on 2021/10/09.
//

import UIKit
import TextFieldEffects

class ProfileViewController: UIViewController {

    @IBOutlet var cactustImageView2: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var nicknameTextField: HoshiTextField!
    @IBOutlet var heightTextField: HoshiTextField!
    @IBOutlet var weightTextField: HoshiTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: 75/255, green: 157/255, blue: 125/255, alpha: 1.0)
        
        saveButton.title = "저장"
        
        textFieldSetting(textFieldName: nicknameTextField)
        textFieldSetting(textFieldName: heightTextField)
        textFieldSetting(textFieldName: weightTextField)
        
        nicknameTextField.placeholder = "닉네임을 설정해주세요"
        heightTextField.placeholder = "키(cm)를 설정해주세요"
        weightTextField.placeholder = "몸무게(kg)를 설정해주세요"
        
        
    }
    
    func textFieldSetting(textFieldName textfield: HoshiTextField) {
        
        textfield.borderStyle = .none
        textfield.placeholderColor = .white
        textfield.placeholderFontScale = 0.8
        textfield.textColor = .white
        textfield.font = UIFont.systemFont(ofSize: 20)
        textfield.borderActiveColor = .white
        textfield.borderInactiveColor = .white
        
        
        
        
    }

}
