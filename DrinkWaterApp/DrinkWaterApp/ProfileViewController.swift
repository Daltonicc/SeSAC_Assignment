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
        heightTextField.keyboardType = .numberPad
        
        let weight = UserDefaults.standard.integer(forKey: "weight")
        weightTextField.text = String(weight)
        weightTextField.keyboardType = .numberPad
        
        cactusImageAndLabelColorChange()
        
        
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
    
    func percentCalculating() -> Int {
        
        let water = UserDefaults.standard.double(forKey: "water")
        let sumWater = UserDefaults.standard.integer(forKey: "drinkWater2")
        let percent = Double(sumWater) / (water * 1000)
        let result = Int(round(percent * 100))
        
        UserDefaults.standard.set(result, forKey: "percent")
        
        let updatePercent = UserDefaults.standard.integer(forKey: "percent")
        
        return(updatePercent)
        
    }
    
    func cactusImageAndLabelColorChange() {
        
        let percent = percentCalculating()
        
        if percent <= 10 {
            cactustImageView2.image = UIImage(named: "1-1")
        } else if percent <= 20 {
            cactustImageView2.image = UIImage(named: "1-2")
        } else if percent <= 30 {
            cactustImageView2.image = UIImage(named: "1-3")
        } else if percent <= 40 {
            cactustImageView2.image = UIImage(named: "1-4")
        } else if percent <= 50 {
            cactustImageView2.image = UIImage(named: "1-5")
        } else if percent <= 60 {
            cactustImageView2.image = UIImage(named: "1-6")
        } else if percent <= 70 {
            cactustImageView2.image = UIImage(named: "1-7")
        } else if percent <= 80 {
            cactustImageView2.image = UIImage(named: "1-8")
        } else if percent > 80 {
            cactustImageView2.image = UIImage(named: "1-9")
        }
        
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
        
        UserDefaults.standard.set(nicknameTextField.text, forKey: "nickname")
        UserDefaults.standard.set(heightTextField.text, forKey: "height")
        UserDefaults.standard.set(weightTextField.text, forKey: "weight")
        
        UserDefaults.standard.string(forKey: "nickname")
        let height = UserDefaults.standard.double(forKey: "height")
        let weight = UserDefaults.standard.double(forKey: "weight")
        
        let water: Double = (height + weight) / 100
        UserDefaults.standard.set(water, forKey: "water")
        
        
    }
    
    
    
}
