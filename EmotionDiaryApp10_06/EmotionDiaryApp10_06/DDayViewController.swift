//
//  DDayViewController.swift
//  EmotionDiaryApp10_06
//
//  Created by 박근보 on 2021/10/07.
//

import UIKit
import SideMenu

class DDayViewController: UIViewController {

    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }
        
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        
        print(datePicker.date)
        print(sender.date)
        
        //DateFormatter: 1. Dateformat 2. 한국
        let format = DateFormatter()
        format.dateFormat = "yy/MM/dd" // 21/10/07
        
        let value = format.string(from: sender.date)
        print(value)
        
        //100일 뒤: TimeInterval
        let afterDate = Date(timeInterval: 86400 * 100, since: sender.date)
        print(afterDate)
    }
    
}
