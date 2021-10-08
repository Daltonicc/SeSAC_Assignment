//
//  EmotionViewController.swift
//  EmotionDiaryApp10_06
//
//  Created by 박근보 on 2021/10/06.
//

import UIKit

class EmotionViewController: UIViewController {

    @IBOutlet var emotionLabel: UILabel!
    @IBOutlet var emotionLabel2: UILabel!
    @IBOutlet var emotionLabel3: UILabel!
    @IBOutlet var emotionLabel4: UILabel!
    @IBOutlet var emotionLabel5: UILabel!
    @IBOutlet var emotionLabel6: UILabel!
    @IBOutlet var emotionLabel7: UILabel!
    @IBOutlet var emotionLabel8: UILabel!
    @IBOutlet var emotionLabel9: UILabel!
    
    //notification 관련 학습
    let userNotificationCenter = UNUserNotificationCenter.current()
    
    
    
    //피드백
    //1. 테두리 색상, 2. 커스텀 컬러(RGB: 0~255)
//    emotionLabel.layer.borderColor = UIColor.red.cgColor()
//    emotionLabel.backgroundColor = .red
    
    // alpha는 투명도를 의미
//    emotionLabel.backgroundColor = UIColor(red: 174/255 , green: 235/255, blue: 190/255, alpha: 0.8)
//    emotionLabel.backgroundColor = UIColor(named: "contentBackground")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion1")
        emotionLabel.text = "행복해 \(emotionNumber1)"
        
        let emotionNumber2 = UserDefaults.standard.integer(forKey: "emotion2")
        emotionLabel.text = "사랑해 \(emotionNumber2)"
        
        let emotionNumber3 = UserDefaults.standard.integer(forKey: "emotion3")
        emotionLabel.text = "좋아해 \(emotionNumber3)"
        
        let emotionNumber4 = UserDefaults.standard.integer(forKey: "emotion4")
        emotionLabel.text = "당황해 \(emotionNumber4)"
        
        let emotionNumber5 = UserDefaults.standard.integer(forKey: "emotion5")
        emotionLabel.text = "속상해 \(emotionNumber5)"
        
        let emotionNumber6 = UserDefaults.standard.integer(forKey: "emotion6")
        emotionLabel.text = "우울해 \(emotionNumber6)"
        
        let emotionNumber7 = UserDefaults.standard.integer(forKey: "emotion7")
        emotionLabel.text = "심심해 \(emotionNumber7)"
        
        let emotionNumber8 = UserDefaults.standard.integer(forKey: "emotion8")
        emotionLabel.text = "짜증나 \(emotionNumber8)"
        
        let emotionNumber9 = UserDefaults.standard.integer(forKey: "emotion9")
        emotionLabel.text = "아파 \(emotionNumber9)"
        
        requestNotificationAuthorization()
    }
    
    @IBAction func emotionImageCliked(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion1")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion1")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion1")
        emotionLabel.text = "행복해 \(updateEmotionNumber1)"
        
    }

    @IBAction func emotionImageCliked2(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion2")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion2")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion2")
        emotionLabel2.text = "사랑해 \(updateEmotionNumber1)"
        
    }
    
    @IBAction func emotionImageCliked3(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion3")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion3")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion3")
        emotionLabel3.text = "좋아해 \(updateEmotionNumber1)"
        
    }
    
    @IBAction func emotionImageCliked4(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion4")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion4")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion4")
        emotionLabel4.text = "당황해 \(updateEmotionNumber1)"
        
    }
    
    @IBAction func emotionImageCliked5(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion5")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion5")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion5")
        emotionLabel5.text = "속상해 \(updateEmotionNumber1)"
        
    }
    
    @IBAction func emotionImageCliked6(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion6")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion6")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion6")
        emotionLabel6.text = "우울해 \(updateEmotionNumber1)"
        
    }
    
    @IBAction func emotionImageCliked7(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion7")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion7")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion7")
        emotionLabel7.text = "심심해 \(updateEmotionNumber1)"
        
    }
    
    @IBAction func emotionImageCliked8(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion8")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion8")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion8")
        emotionLabel8.text = "짜증나 \(updateEmotionNumber1)"
        
    }
    
    @IBAction func emotionImageCliked9(_ sender: UIButton) {
        
        let emotionNumber1 = UserDefaults.standard.integer(forKey: "emotion9")
        
        UserDefaults.standard.set(emotionNumber1 + 1, forKey: "emotion9")
        
        let updateEmotionNumber1 = UserDefaults.standard.integer(forKey: "emotion9")
        emotionLabel9.text = "아파 \(updateEmotionNumber1)"
        
    }
    
    //Notification 학습
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

            userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
                      
                if success {
                    self.sendNotification()
                }
                
            }
    }
    
    func sendNotification() {
        
        //어떤 정보를 보낼지 컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        notificationContent.badge = 100
        
        //언제 보낼 지 구성: 1. 간격, 2. 캘린더, 3.위치
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        //알림 요청
        let request = UNNotificationRequest(identifier: "\(Date())",
                                                        content: notificationContent,
                                                        trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
}
