//
//  ShoppingListTableViewCell.swift
//  ShoppingListApp
//
//  Created by 박근보 on 2021/10/14.
//

import UIKit
import RealmSwift

class ShoppingListTableViewCell: UITableViewCell {

    
    static let identifier = "shoppingListCell"
    
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var toDoListLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var favoriteStatuscell = false
    var successStatuscell = false
    
    
}
    
