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
        
        textFieldSetting(textFieldName: nicknameTextField, placeholder: "닉네임을 설정해주세요")
        textFieldSetting(textFieldName: heightTextField, placeholder: "키(cm)를 설정해주세요")
        textFieldSetting(textFieldName: weightTextField, placeholder: "몸무게(kg)를 설정해주세요")
        
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        nicknameTextField.text = nickname
        
        let height = UserDefaults.standard.integer(forKey: "height")
        heightTextField.text = String(height)
        
        let weight = UserDefaults.standard.integer(forKey: "weight")
        weightTextField.text = String(weight)
        
        
    }
    
    func textFieldSetting(textFieldName textfield: HoshiTextField, placeholder place: String = "예시") {
        
        textfield.placeholder = place
        textfield.borderStyle = .none
        textfield.placeholderColor = .white
        textfield.placeholderFontScale = 0.8
        textfield.textColor = .white
        textfield.font = UIFont.systemFont(ofSize: 20)
        textfield.borderActiveColor = .white
        textfield.borderInactiveColor = .white
        
    }

    @IBAction func tapGestureClicked(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @IBAction func nicknameTextFieldClicked(_ sender: HoshiTextField) {
    }
    
    @IBAction func heightTextFieldClicked(_ sender: HoshiTextField) {

    }
    
    @IBAction func weightTextFieldClicked(_ sender: HoshiTextField) {

    }
    
    
    @IBAction func saveButtonClicked(_ sender: UIBarButtonItem) {
        
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "nickname")
        UserDefaults.standard.set(heightTextField.text!, forKey: "height")
        UserDefaults.standard.set(weightTextField.text!, forKey: "weight")
        
        let nickname = UserDefaults.standard.string(forKey: "nickname")
        let height = UserDefaults.standard.double(forKey: "height")
        let weight = UserDefaults.standard.double(forKey: "weight")
        
        let water: Double = (height + weight) / 100
        UserDefaults.standard.set(water, forKey: "water")
    }
    
    
    
}
