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
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lotteryNumberLabel: UILabel!
    @IBOutlet weak var firstNumber: UILabel!
    @IBOutlet weak var secondNumber: UILabel!
    @IBOutlet weak var thirdNumber: UILabel!
    @IBOutlet weak var fourthNumber: UILabel!
    @IBOutlet weak var fifthNumber: UILabel!
    @IBOutlet weak var sixthNumber: UILabel!
    @IBOutlet weak var bonusNumber: UILabel!
    @IBOutlet weak var borderView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let picker = UIPickerView()
        picker.delegate = self
        
        lotteryTextField.inputView = picker
        lotteryTextField.text = "986"
        lotteryTextField.textAlignment = .center
        
        numberLabelSetting(label: firstNumber, atFirstNumber: "7")
        numberLabelSetting(label: secondNumber, atFirstNumber: "10")
        numberLabelSetting(label: thirdNumber, atFirstNumber: "16")
        numberLabelSetting(label: fourthNumber, atFirstNumber: "28")
        numberLabelSetting(label: fifthNumber, atFirstNumber: "41")
        numberLabelSetting(label: sixthNumber, atFirstNumber: "42")
        numberLabelSetting(label: bonusNumber, atFirstNumber: "40")
        
        borderView.layer.addBorder([.bottom], color: .gray, width: 1.0)
        
        getlotteryNumber()
        toolBarPickerView()
    
    }

    @IBAction func pickerTextfieldClicked(_ sender: UITextField) {
    
    }
    
    func numberLabelSetting(label: UILabel, atFirstNumber: String) {
        
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.layer.cornerRadius = 20
        label.layer.masksToBounds = true
        label.text = atFirstNumber
        
        lotteryNumberLabel.textColor = .systemYellow
        lotteryNumberLabel.textAlignment = .right
        lotteryNumberLabel.font = UIFont.boldSystemFont(ofSize: 23)
        lotteryNumberLabel.text = "986회"
        
        dateLabel.textColor = .gray
        dateLabel.text = "2021-10-23"
        
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
        
        let nowNumber = lotteryTextField.text ?? "986"
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(nowNumber)"

        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let date = json["drwNoDate"].stringValue
                let lotteryNumber = json["drwNo"].intValue
                let number1 = json["drwtNo1"].intValue
                let number2 = json["drwtNo2"].intValue
                let number3 = json["drwtNo3"].intValue
                let number4 = json["drwtNo4"].intValue
                let number5 = json["drwtNo5"].intValue
                let number6 = json["drwtNo6"].intValue
                let numberBonus = json["bnusNo"].intValue
                
                self.dateLabel.text = date
                self.lotteryNumberLabel.text = "\(lotteryNumber)회"
                self.firstNumber.text = "\(number1)"
                self.secondNumber.text = "\(number2)"
                self.thirdNumber.text = "\(number3)"
                self.fourthNumber.text = "\(number4)"
                self.fifthNumber.text = "\(number5)"
                self.sixthNumber.text = "\(number6)"
                self.bonusNumber.text = "\(numberBonus)"
                
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
        
        getlotteryNumber()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let list = Array(numberList.sorted().reversed())
        return "\(list[row])"
        
    }
    
}

//커스텀 Border
extension CALayer {
    func addBorder(_ arr_edge: [UIRectEdge], color: UIColor, width: CGFloat) {
        for edge in arr_edge {
            let border = CALayer()
            switch edge {
            case UIRectEdge.top:
                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
                break
            case UIRectEdge.bottom:
                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
                break
            case UIRectEdge.left:
                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
                break
            case UIRectEdge.right:
                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
                break
            default:
                break
            }
            border.backgroundColor = color.cgColor;
            self.addSublayer(border)
        }
    }
}


//코드로 구현한 피커뷰에는 툴바가 정상적으로 삽입이 되는데, 스토리보드에서 작성한 피커뷰에는 툴바가 안들어가짐.
//commit test
