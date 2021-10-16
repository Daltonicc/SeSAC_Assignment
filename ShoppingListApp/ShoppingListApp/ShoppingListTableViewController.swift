//
//  ShoppingListTableViewController.swift
//  ShoppingListApp
//
//  Created by 박근보 on 2021/10/14.
//

import UIKit

class ShoppingListTableViewController: UITableViewController {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var inputButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        inputTextField.layer.borderWidth = 2
        inputTextField.placeholder = "무엇을 구매하실 건가요?"
        
        inputButton.setTitle("추가", for: .normal)
        inputButton.tintColor = .black
        inputButton.backgroundColor = .white
        inputButton.layer.borderColor = UIColor.black.cgColor
        inputButton.layer.borderWidth = 2
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 4
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ShoppingListTableViewCell.identifier, for: indexPath) as? ShoppingListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.backgroundColor = .white
        cell.leftCheckButton.backgroundColor = .white
        cell.leftCheckButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        cell.leftCheckButton.tintColor = .black

//      cell.toDoListLabel.text = "rsdede"
        cell.toDoListLabel.textColor = .black
        
        cell.favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        cell.favoriteButton.tintColor = .black
        
        
        
        return cell
    }
}


//테이블뷰 좌우 마진 값 어떻게 줘야하지?
//디자인이 안된다..
