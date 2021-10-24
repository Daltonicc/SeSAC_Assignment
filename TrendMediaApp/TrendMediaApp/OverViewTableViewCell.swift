//
//  OverViewTableViewCell.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/20.
//

import UIKit

class OverViewTableViewCell: UITableViewCell {
    
    static let identifier = "overviewCell"

    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var chevronButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
