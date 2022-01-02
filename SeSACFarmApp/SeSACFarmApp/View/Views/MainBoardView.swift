//
//  MainBoardView.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/03.
//

import Foundation
import UIKit
import SnapKit

class MainBoardView: UIView {
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    func setUpView() {
        
        addSubview(tableView)
    }
    
    func setUpConstraints() {
        
        tableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}
