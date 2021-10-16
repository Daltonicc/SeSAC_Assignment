//
//  TvShowTableViewCell.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit

class TvShowTableViewCell: UITableViewCell {


    static let identifier = "TvShowCell"
    
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var koreanTitleLabel: UILabel!
    @IBOutlet weak var releaseLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var showView: UIView!
    @IBOutlet weak var subRateLabel: UILabel!
    
    
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
