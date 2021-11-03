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
            
            //프라이머리 키를 아이디로
            saveImageToDocoumentDirectory(imageName: "\(task._id).jpg", image: topImageView.image!)
        }
        
    }

    func saveImageToDocoumentDirectory(imageName: String, image: UIImage) {
        
        //1. 이미지 저장할 경로 설정: 도큐먼트 폴더(.documentDirectory), FileManager
        // Desktop/jack/ios/folder
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 파일 이름
        // Desktop/jack/ios/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        //3. 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        //4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        //4-1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            //4-2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
        
        //5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지 저장 못함")
        }
        
    }
}
