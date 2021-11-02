//
//  PlusDiaryViewController.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/02.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    let localRealm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bottomSetting()
        navigationItemSetting()
        
        print("Realm is located at:", localRealm.configuration.fileURL!)
        
    }
    
    func bottomSetting() {
        
        titleTextField.backgroundColor = .systemGray4
        dateButton.backgroundColor = .systemGray4
        contentTextView.backgroundColor = .systemGray4
        
    }
    
    func navigationItemSetting() {
        
        title = "일기 작성"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
    }
    
    @objc func cancelButtonClicked() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func uiSetting() {
        
        topImageView.image = UIImage(named: "배경")
        topImageView.contentMode = .scaleAspectFill
        
    }
    
    @objc func saveButtonClicked() {
        
        let task = UserDiary(diaryTitle: titleTextField.text!, diaryContent: contentTextView.text!, writeDate: Date(), registerDate: Date() )
        try! localRealm.write {
            localRealm.add(task)
        }
        
    }

}
