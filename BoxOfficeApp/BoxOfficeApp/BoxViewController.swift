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

    let localRealm = try! Realm()
    var lists: Results<BoxOfficeList>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lists = localRealm.objects(BoxOfficeList.self)
        
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.backgroundColor = .black
        
        dateSearchBar.delegate = self
        
        print("Realm is located at:", localRealm.configuration.fileURL!)

    }


}

// MARK: - Extension

extension BoxViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BoxOfficeTableViewCell.identifier, for: indexPath) as? BoxOfficeTableViewCell else { return UITableViewCell() }
        
        let row = lists[indexPath.row]
        
        cell.backgroundColor = .black
    
        cell.rankLabel.text = row.rank
        
        cell.titleLabel.text = row.title
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        
        cell.releaseDateLabel.text = row.releaseDate
        
        return cell
    }
    
}

extension BoxViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        if let text = dateSearchBar.text {
            
           lists = BoxAPIManager.shared.getBoxOfficeDataFromDB(date: text)
            
            //DB에서 가져온 데이터가 없다면 API통신
            if lists.count == 0 {
                
                BoxAPIManager.shared.getBoxOfficeData(date: text) { json in
                    
                    self.boxOfficeTableView.reloadData()
                }
            
                //있으면 lists가 업데이트 됐으므로 테이블뷰 리로드
            } else {
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
