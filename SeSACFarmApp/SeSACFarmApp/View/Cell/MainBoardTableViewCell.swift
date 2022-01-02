//
//  MainBoardTableViewCell.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/03.
//

import UIKit
import SnapKit

class MainBoardTableViewCell: UITableViewCell {

    static let identifier = "MainBoardTableViewCell"
    
    let nicknameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .systemGray2
        label.textColor = .systemGray6
        label.font = .systemFont(ofSize: 15)
        label.layer.cornerRadius = 5
        return label
    }()
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        return label
    }()
    let createDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray6
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let commentView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    let commentImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    let commentCountLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setUpView() {
        
        addSubview(nicknameLabel)
        addSubview(contentLabel)
        addSubview(createDateLabel)
        addSubview(commentView)
        commentView.addSubview(commentImageView)
        commentView.addSubview(commentCountLabel)
    }
    
    func setUpConstraints() {
        
        nicknameLabel.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.leading.equalTo(self.snp.leading).offset(20)
            make.height.equalTo(20)
        }
    }
}
