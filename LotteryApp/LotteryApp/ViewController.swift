//
//  ViewController.swift
//  LotteryApp
//
//  Created by 박근보 on 2021/10/25.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    var numberList = Array<Int>(1...986)
    
    @IBOutlet weak var lotteryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView()
        picker.delegate = self
        
        lotteryTextField.inputView = picker
        lotteryTextField.text = "986"
        
        getlotteryNumber()
        toolBarPickerView()
    
    }

    @IBAction func pickerTextfieldClicked(_ sender: UITextField) {
    
    }
    
    func toolBarPickerView() {
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = .black
        let button = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(pickerViewSetting))
        toolBar.setItems([button], animated: true)
        toolBar.frame = CGRect(x: 0, y: 0, width: 0, height: 35)
        
        lotteryTextField.inputAccessoryView = toolBar
        
    }
    
    @objc func pickerViewSetting() {
        self.view.endEditing(true)
        
    }
    
    func getlotteryNumber() {
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
            case .failure(let error):
                print(error)
            }
        }

    }

}

//PickerView
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return numberList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(#function)
        
        let list = Array(numberList.sorted().reversed())
        lotteryTextField.text = "\(list[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let list = Array(numberList.sorted().reversed())
        return "\(list[row])"
        
    }
    
}

//코드로 구현한 피커뷰에는 툴바가 정상적으로 삽입이 되는데, 스토리보드에서 작성한 피커뷰에는 툴바가 안들어가짐.
