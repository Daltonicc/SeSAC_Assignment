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
    
    var favoriteStatus2 = false
    var successStatus2 = false
    
    let localRealm = try! Realm()
    var tasks: Results<ShoppingList>!

    
    
    // MARK: - 메서드
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        inputTextField.layer.borderWidth = 2
        inputTextField.placeholder = "무엇을 구매하실 건가요?"
        
        buttonSetting()
        
        tasks = localRealm.objects(ShoppingList.self)
        
        
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
    
        if favoriteStatus2 == false {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            favoriteStatus2 = true
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            favoriteStatus2 = false

        }
        
    }
    
    @IBAction func successButtonClicked(_ sender: UIButton) {
    
        if successStatus2 == false {
            successButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
            successStatus2 = true
        } else {
            successButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            successStatus2 = false

        }
        
    }
    
    @IBAction func inputButtonClicked(_ sender: UIButton) {
   
        if let text = inputTextField.text {
            let task = ShoppingList(shoppingContent: text, favoriteStatus: favoriteStatus2, successStatus: successStatus2)
            try! localRealm.write {
                localRealm.add(task)
                tableView.reloadData()
            }
            
        } else {
            print("텍스트 없음")
        }
        
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
        cell.leftCheckButton.backgroundColor = .white
        cell.leftCheckButton.tintColor = .black
        if cell.successStatuscell == true {
            cell.leftCheckButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            cell.leftCheckButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
        
        cell.toDoListLabel.text = row.shoppingContent
        cell.toDoListLabel.textColor = .black
        
        cell.favoriteStatuscell = row.favoriteStatus
        cell.favoriteButton.tintColor = .black
        if cell.favoriteStatuscell == true {
            cell.favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            cell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
            
        }
        
        return cell
    }
}

//데이터베이스에서 삭제하는 법은?
