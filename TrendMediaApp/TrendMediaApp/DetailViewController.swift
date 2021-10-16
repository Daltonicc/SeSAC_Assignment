//
//  DetailViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tvShowInformation = TvShowInformation()

    @IBOutlet weak var CastTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CastTableView.delegate = self
        CastTableView.dataSource = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonClikced))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.title = "출연/제작"
        
    }
    
    @objc func backButtonClikced() {
        
        self.navigationController?.popViewController(animated: true)
    
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        
        cell.actorImageView.image = UIImage(named: row.title)
        cell.actorImageView.layer.cornerRadius = 3
        cell.actorImageView.contentMode = .scaleAspectFill
        
        cell.nameLabel.text = row.koreanTitle
        
        cell.realNamelabel.text = row.title
        cell.realNamelabel.textColor = .lightGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }

}
