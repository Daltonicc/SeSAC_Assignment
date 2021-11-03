//
//  ViewController.swift
//  BoxOfficeApp
//
//  Created by 박근보 on 2021/11/03.
//

import UIKit
import Alamofire
import SwiftyJSON

class BoxViewController: UIViewController {

    @IBOutlet weak var boxOfficeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.backgroundColor = .black
        
        BoxAPIManager.shared.getBoxOfficeData { json in
            
            self.boxOfficeTableView.reloadData()
            
        }
        
    }


}

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
