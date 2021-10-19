//
//  DetailViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tvShowInformation = TvShowInformation()
    var tvShowData: TvShow?
    

    @IBOutlet weak var CastTableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerSmallImageView: UIImageView!
    @IBOutlet weak var headerImageNameLabel: UILabel!
    @IBOutlet weak var headerOverViewLabel: UILabel!
    @IBOutlet weak var toggleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CastTableView.delegate = self
        CastTableView.dataSource = self
        
        headerViewSetting()
        
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonClikced))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.title = "출연/제작"
        
    }
    
    func headerViewSetting() {
        let url = URL(string: tvShowData?.backdropImage ?? "https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg")
        
        headerImageView.kf.setImage(with: url)
        headerImageView.contentMode = .scaleAspectFill
        
        headerSmallImageView.image = UIImage(named: tvShowData?.title ?? "Maid")
        headerSmallImageView.contentMode = .scaleAspectFill
        
        headerImageNameLabel.text = tvShowData?.title ?? "내용 없음"
        headerImageNameLabel.textColor = .white
        headerImageNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        headerOverViewLabel.text = tvShowData?.overview ?? "내용 없음"
        headerOverViewLabel.numberOfLines = 0
        
        toggleButton.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
//        toggleButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
    }
    
    @objc func backButtonClikced() {
        
        self.navigationController?.popViewController(animated: true)
    
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInformation.tvShow.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
        
        
        
        cell.actorImageView.backgroundColor = .gray
        cell.actorImageView.layer.cornerRadius = 3
        cell.actorImageView.contentMode = .scaleAspectFill
        
        cell.nameLabel.text = "배우 이름"
        
        cell.realNamelabel.text = "정보 없음"
        cell.realNamelabel.textColor = .lightGray
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 10
    }

}
