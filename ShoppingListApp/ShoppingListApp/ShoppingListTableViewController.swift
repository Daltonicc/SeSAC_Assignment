//
//  ShoppingListTableViewController.swift
//  ShoppingListApp
//
//  Created by 박근보 on 2021/10/14.
//

import UIKit
import RealmSwift

class ShoppingListTableViewController: UITableViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var successButton: UIButton!
    
    var favoriteStatus = false
    var successStatus = false
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        inputTextField.layer.borderWidth = 2
        inputTextField.placeholder = "무엇을 구매하실 건가요?"
        
        buttonSetting()
        
        tasks = localRealm.objects(ShoppingList.self)
        
        navigationItemSetting()
        
    }
    
    // MARK: - func
    
    func navigationItemSetting() {
        
        let filterButton = UIBarButtonItem(title: "정렬", style: .plain, target: self, action: #selector(filterButtonClicked))
        filterButton.tintColor = .gray
        navigationItem.rightBarButtonItem = filterButton
    
    }
    
    
    func buttonSetting() {
        
        inputButton.setTitle("추가", for: .normal)
        inputButton.tintColor = .black
        inputButton.backgroundColor = .white
        inputButton.layer.borderColor = UIColor.black.cgColor
        inputButton.layer.borderWidth = 2
        
        favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        favoriteButton.tintColor = .black
        
        successButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        successButton.tintColor = .black
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
    
        if favoriteStatus == false {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favoriteStatus = true
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            favoriteStatus = false

        }
        
    }
    
    @IBAction func successButtonClicked(_ sender: UIButton) {
    
        if successStatus == false {
            successButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            successStatus = true
        } else {
            successButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            successStatus = false

        }
        
    }
    
    @IBAction func inputButtonClicked(_ sender: UIButton) {
   
        if let text = inputTextField.text {
            let task = ShoppingList(shoppingContent: text, favoriteStatus: favoriteStatus, successStatus: successStatus)
            try! localRealm.write {
                localRealm.add(task)
                tableView.reloadData()
            }
            
        } else {
            print("텍스트 없음")
        }
        
    }

    // MARK: - objc func
    
    @objc func filterButtonClicked() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let favoriteFilterAction = UIAlertAction(title: "즐겨찾는 항목", style: .default) { _ in
            
            self.tasks = self.tasks.filter("favoriteStatus == true")
            self.tableView.reloadData()
        }
        
        let successFilterAction = UIAlertAction(title: "미완료 항목", style: .default) { _ in
            
            self.tasks = self.tasks.filter("successStatus == false")
            self.tableView.reloadData()
        }
        
        let allFilterAction = UIAlertAction(title: "전체 보기", style: .default) { _ in
            
            self.tasks = self.tasks.filter("successStatus != nil")
            self.tableView.reloadData()
            
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancel)
        alert.addAction(favoriteFilterAction)
        alert.addAction(successFilterAction)
        alert.addAction(allFilterAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    @objc func checkButtonClicked(_ sender: UIButton) {
        
        let taskUpdate = tasks[sender.tag]
        
        try! localRealm.write {
            if taskUpdate.successStatus == true {
                taskUpdate.successStatus = false
            } else {
                taskUpdate.successStatus = true
            }

        }
        tableView.reloadData()
    }

    @objc func cellFavoriteButtonClicked(_ sender: UIButton) {
        
        let taskUpdate = tasks[sender.tag]
        
        try! localRealm.write {
            if taskUpdate.favoriteStatus == true {
                taskUpdate.favoriteStatus = false
            } else {
                taskUpdate.favoriteStatus = true
            }

        }
        tableView.reloadData()
    }
    
    // MARK: - 테이블뷰
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        
        
        let row = tasks[indexPath.row]
        
        cell.backgroundColor = .white
        
        cell.successStatuscell = row.successStatus
        cell.checkButton.backgroundColor = .white
        cell.checkButton.tintColor = .black
        cell.checkButton.tag = indexPath.row
        if cell.successStatuscell == true {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.checkButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        
        cell.toDoListLabel.text = row.shoppingContent
        cell.toDoListLabel.textColor = .black
        
        cell.favoriteStatuscell = row.favoriteStatus
        cell.favoriteButton.tintColor = .black
        cell.favoriteButton.tag = indexPath.row
        if cell.favoriteStatuscell == true {
            cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
        cell.favoriteButton.addTarget(self, action: #selector(cellFavoriteButtonClicked), for: .touchUpInside)
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        let row = tasks[indexPath.row]
        
        try! localRealm.write {
            
            localRealm.delete(row)
            tableView.reloadData()
        }
    }
    
}


