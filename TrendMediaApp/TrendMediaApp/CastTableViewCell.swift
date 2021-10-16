//
//  CastTableViewCell.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    static let identifier = "CastCell"
    
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var realNamelabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
