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
    

    

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
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
        
        cell.dateLabel.text = "\(row.writeDate)"
        cell.dateLabel.font = UIFont.systemFont(ofSize: 16)
        
        cell.diaryImageView.backgroundColor = .blue
        cell.diaryImageView.layer.cornerRadius = 10
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
