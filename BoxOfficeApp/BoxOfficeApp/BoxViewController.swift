//
//  ViewController.swift
//  BoxOfficeApp
//
//  Created by 박근보 on 2021/11/03.
//

import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

class BoxViewController: UIViewController {

    @IBOutlet weak var boxOfficeTableView: UITableView!
    @IBOutlet weak var dateSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let localRealm = try! Realm()
        var lists: Results<BoxOfficeList>!
        
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.backgroundColor = .black
        
        dateSearchBar.delegate = self
        
        print("Realm is located at:", localRealm.configuration.fileURL!)

        
        BoxAPIManager.shared.getBoxOfficeData(date: "") { json in
            
            self.boxOfficeTableView.reloadData()
            
        }
        
    }


}

// MARK: - Extension

extension BoxViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BoxAPIManager.shared.boxData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        
        let boxRow = BoxAPIManager.shared.boxData[indexPath.row]
        
        cell.backgroundColor = .black
        
        cell.rankLabel.text = boxRow.rank
        
        cell.titleLabel.text = boxRow.title
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        
        cell.releaseDateLabel.text = boxRow.releaseDate
        
        return cell
    }
    
}

extension BoxViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = dateSearchBar.text {
            
            BoxAPIManager.shared.boxData.removeAll()
            BoxAPIManager.shared.getBoxOfficeData(date: text) { json in
                
                self.boxOfficeTableView.reloadData()
            }
            // 분명 아무 내용도 없는데 else 문으로 가지를 않는다..
        } else {
            let alert = UIAlertController(title: "날짜를 제대로 입력하지 않았습니다.", message: "양식에 맞춰 날짜를 입력해주세요!", preferredStyle: .alert)
            let okay = UIAlertAction(title: "확인", style: .default)

            alert.addAction(okay)
            
            present(alert, animated: true)
        }
    }
}
