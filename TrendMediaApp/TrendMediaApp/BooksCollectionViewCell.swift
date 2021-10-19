//
//  BooksCollectionViewCell.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/19.
//

import UIKit

class BooksCollectionViewCell: UICollectionViewCell {

    static let identifier = "BooksCollectionViewCell"
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }

}
