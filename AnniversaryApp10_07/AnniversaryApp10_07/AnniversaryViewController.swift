//
//  AnniversaryViewController.swift
//  AnniversaryApp10_07
//
//  Created by 박근보 on 2021/10/07.
//

import UIKit

class AnniversaryViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet var dDayLabel1: UILabel!
    @IBOutlet var dDayLabel2: UILabel!
    @IBOutlet var dDayLabel3: UILabel!
    @IBOutlet var dDayLabel4: UILabel!
    
    @IBOutlet var yearLabel1: UILabel!
    @IBOutlet var yearLabel2: UILabel!
    @IBOutlet var yearLabel3: UILabel!
    @IBOutlet var yearLabel4: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        } else {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        dDayLabelSetting(labelName: dDayLabel1)
        dDayLabelSetting(labelName: dDayLabel2)
        dDayLabelSetting(labelName: dDayLabel3)
        dDayLabelSetting(labelName: dDayLabel4)
        
        yearLabelSetting(labelName: yearLabel1)
        yearLabelSetting(labelName: yearLabel2)
        yearLabelSetting(labelName: yearLabel3)
        yearLabelSetting(labelName: yearLabel4)
        
        dDayLabel1.text = " D+100"
        dDayLabel2.text = " D+200"
        dDayLabel3.text = " D+300"
        dDayLabel4.text = " D+400"
        
    }
    
    // 레이블의 텍스트 설정은 사용자 정의 함수로 설정할 수 있게 어떻게?
    func dDayLabelSetting(labelName label: UILabel) {
        
        
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        label.textAlignment = .left
    }
    
    func yearLabelSetting(labelName label: UILabel) {
        
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 2
    }
    
    @IBAction func datePickerAction(_ sender: UIDatePicker) {
        
        let format = DateFormatter()
        format.dateFormat = "yyyy년 MM월 dd일"
        
        let value = format.string(from: sender.date)
        print(value)
        
        // D + 100
        let d100Date = Date(timeInterval: 86400 * 100, since: sender.date)
        let d100Value = format.string(from: d100Date)
        
        let d200Date = Date(timeInterval: 86400 * 200, since: sender.date)
        let d200Value = format.string(from: d200Date)
        
        let d300Date = Date(timeInterval: 86400 * 300, since: sender.date)
        let d300Value = format.string(from: d300Date)
        
        let d400Date = Date(timeInterval: 86400 * 400, since: sender.date)
        let d400Value = format.string(from: d400Date)
        
        yearLabel1.text = d100Value
        yearLabel2.text = d200Value
        yearLabel3.text = d300Value
        yearLabel4.text = d400Value
    
    }
    

}



// 이미지뷰안에 스택뷰를 넣는 건 불가능?
// 아니면 스택뷰의 백그라운드에 이미지를 넣는건 안되나?
