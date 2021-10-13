//
//  Case2TableViewController.swift
//  03Week_Study
//
//  Created by 박근보 on 2021/10/12.
//
//
//
//

import UIKit

class Case2TableViewController: UITableViewController {

    let firstSectionList = ["공지사항", "실험실", "버전 정보"]
    let secondSectionList = ["개인/보안", "알림", "채팅", "멀티프로필"]
    let thirdSectionList = ["고객센터/도움말"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 3
        } else if section == 1 {
            return 4
        } else {
            return 1
        }

    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell") else {
            
            return UITableViewCell()
        }
        if indexPath.section == 0 {
            cell.textLabel?.text = firstSectionList[indexPath.row]
        } else if indexPath.section == 1 {
            cell.textLabel?.text = secondSectionList[indexPath.row]
        } else {
            cell.textLabel?.text = thirdSectionList[indexPath.row]
        }
        
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        cell.layer.borderColor = UIColor.white.cgColor
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "전체 설정"
        } else if section == 1 {
            return "개인 설정"
        } else {
            return "기타"
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(displayP3Red: 176/255, green: 181/255, blue: 180/255, alpha: 1.0)
        header.textLabel?.font = UIFont.systemFont(ofSize: 18)
    }
    
    
}
