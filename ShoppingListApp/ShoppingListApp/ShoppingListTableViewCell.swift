//
//  ShoppingListTableViewCell.swift
//  ShoppingListApp
//
//  Created by 박근보 on 2021/10/14.
//

import UIKit

class ShoppingListTableViewCell: UITableViewCell {

    
    static let identifier = "shoppingListCell"
    
    @IBOutlet weak var leftCheckButton: UIButton!
    @IBOutlet weak var toDoListLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    @IBAction func leftButtonClicked(_ sender: UIButton) {
        let image = leftCheckButton.image(for: .normal)
        
        if image == UIImage(systemName: "checkmark.square") {
            leftCheckButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        } else {
            leftCheckButton.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        }
    }
    
    @IBAction func favoriteButtonClicked(_ sender: UIButton) {
        let image = favoriteButton.image(for: .normal)
        
        if image == UIImage(systemName: "star") {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
        
    
}
    
