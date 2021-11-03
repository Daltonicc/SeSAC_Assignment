//
//  SearchViewController.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/02.
//

import UIKit
import RealmSwift

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    
    let localRealm = try! Realm()
    
    var tasks: Results<UserDiary>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        title = "검색"
        
        tasks = localRealm.objects(UserDiary.self)
        
        print(tasks)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        searchTableView.reloadData()
    }
    
    //도큐먼트 폴더 -> 이미지 찾기 -> UIImage -> UIImageView
    func loadImageFromDocumentDirectory(imageName: String) -> UIImage? {
        
        //폴더 찾기
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let path = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let directoryPath = path.first {
            let imageURL = URL(fileURLWithPath: directoryPath).appendingPathComponent(imageName)
            return UIImage(contentsOfFile: imageURL.path)
        }
        
        return nil
    }
    
    //이미지 삭제 메서드
    func deleteImageFromDocumentDirectory(imageName: String) {
        
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        //2. 이미지 파일 이름
        // Desktop/jack/ios/222.png
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
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
    }
    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as! SearchTableViewCell
        
        let row = tasks[indexPath.row]
        
        cell.titleLabel.text = row.diaryTitle
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        cell.contentLabel.text = row.diaryContent
        cell.contentLabel.font = UIFont.systemFont(ofSize: 16)
        cell.contentLabel.textColor = .gray
        cell.contentLabel.numberOfLines = 3
        
        cell.dateLabel.text = "\(row.writeDate)"
        cell.dateLabel.font = UIFont.systemFont(ofSize: 16)
        
        cell.diaryImageView.backgroundColor = .blue
        cell.diaryImageView.layer.cornerRadius = 10
        cell.diaryImageView.image = loadImageFromDocumentDirectory(imageName: "\(row._id).jpg")
        
        return cell
    }
    
    //본래는 화면 전환 + 값 전달 후 새로운 화면에서 수정이 적합
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let tasksToUpdate = tasks[indexPath.row]
        
        //1. 수정 - 레코드에 대한 값 수정
        try! localRealm.write {
            tasksToUpdate.diaryTitle = "새롭게 수정"
            tasksToUpdate.diaryContent = "수정!"
            tableView.reloadData()
        }
        
        //2. 일괄 수정
//        try! localRealm.write {
//            tasks.setValue(Date(), forKey: "writeDate")
//            tasks.setValue("새롭게 일기쓰기", forKey: "diaryTitle")
//            tableView.reloadData()
//        }
        
        //3. 수정: PK 기준으로 수정할 때 사용(권장X)
//        try! localRealm.write {
//            let update = UserDiary(value: [ "_id": tasksToUpdate._id, "diaryTitle": "얘만 바꾸고 싶어"])
//            localRealm.add(update, update: .modified)
//            tableView.reloadData()
//        }
        
        //4. 수정
//        try! localRealm.write {
//            localRealm.create(UserDiary.self, value: [ "_id": tasksToUpdate._id, "diaryTitle": "얘만 바꿀래"], update: .modified)
//            tableView.reloadData()
//        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        try! localRealm.write {
            
            //렘 데이터를 먼저 지워버리면 id값도 죽어버리기 때문에 인덱스 안꼬이게 순서 중요!
            deleteImageFromDocumentDirectory(imageName: "\(row._id).jpg")
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
}
