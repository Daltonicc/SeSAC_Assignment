//
//  SearchViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tvShowInformation = TvShowInformation()
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        view.backgroundColor = .gray
        searchTableView.backgroundColor = .black
        
        topviewSetting()
        
    }
    
    //상단 뷰 UI
    func topviewSetting() {
        
        topView.backgroundColor = .gray
                
        searchView.backgroundColor = .systemGray
        searchView.layer.cornerRadius = 10
                
        showSearchBar.barTintColor = .systemGray
        showSearchBar.searchBarStyle = .minimal
        
        cancelButton.tintColor = .white
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    //테이블뷰 관련 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInformation.tvShow.count
        }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell() }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        
        cell.backgroundColor = .black
        
        cell.leftImageView.image = UIImage(named: row.title)
        
        cell.titleLabel.text = "\(row.koreanTitle)(\(row.title))"
        cell.titleLabel.textColor = .white
        cell.titleLabel.numberOfLines = 0
        
        cell.releaseDateLabel.text = "\(row.releaseDate) | \(row.region)"
        cell.releaseDateLabel.textColor = .systemGray2
        
        cell.overviewLabel.text = row.overview
        cell.overviewLabel.textColor = .gray
        cell.overviewLabel.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height / 6
    }
    
}
