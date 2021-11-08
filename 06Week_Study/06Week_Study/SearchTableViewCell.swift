//
//  SearchTableViewCell.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/02.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var diaryImageView: UIImageView!
    
    func configureCell(row: UserDiary) {
        
        titleLabel.text = row.diaryTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 19)
        
        contentLabel.text = row.diaryContent
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.textColor = .gray
        contentLabel.numberOfLines = 3
        
        dateLabel.text = "\(row.writeDate)"
        dateLabel.font = UIFont.systemFont(ofSize: 16)
        
        diaryImageView.backgroundColor = .blue
        diaryImageView.layer.cornerRadius = 10

        
        
    }
    


}
