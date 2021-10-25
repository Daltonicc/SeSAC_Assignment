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

    @IBOutlet weak var lotteryTextField: UITextField!
    @IBOutlet weak var lotteryPickerVIew: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getlotteryNumber()
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

