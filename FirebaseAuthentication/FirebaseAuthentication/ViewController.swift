//
//  ViewController.swift
//  FirebaseAuthentication
//
//  Created by 박근보 on 2022/01/17.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var identityNumberTextField: UITextField!
    
    var yourID = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .black
        
        phoneTextField.placeholder = "전화번호를 입력해주세요. ex) 01011111111"
    }

    @IBAction func sendButtonClicked(_ sender: UIButton) {
        
        PhoneAuthProvider.provider().verifyPhoneNumber("+82) \(phoneTextField.text ?? "")", uiDelegate: nil) { verificationID, error in
            if let error = error {
                 print(error.localizedDescription)
                 return
            }
            self.yourID = verificationID!
            print(self.yourID)
        }
    }
    
    @IBAction func CheckButtonClicked(_ sender: UIButton) {
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: yourID, verificationCode: identityNumberTextField.text ?? "")
        
        Auth.auth().signIn(with: credential) { success, error in
            if error == nil {
                let alert = UIAlertController(title: "로그인 성공!", message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "로그인 실패", message: "인증키를 다시 확인해주세요", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
                alert.addAction(ok)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

