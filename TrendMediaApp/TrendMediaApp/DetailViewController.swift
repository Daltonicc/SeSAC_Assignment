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
    var openOrNot = false

    @IBOutlet weak var CastTableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerSmallImageView: UIImageView!
    @IBOutlet weak var headerImageNameLabel: UILabel!
    
    
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
        
//        headerOverViewLabel.text = tvShowData?.overview ?? "내용 없음"
//        headerOverViewLabel.numberOfLines = 0
        
//        toggleButton.setImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
////        toggleButton.addTarget(<#T##target: Any?##Any?#>, action: <#T##Selector#>, for: <#T##UIControl.Event#>)
        
    }
    
    @objc func backButtonClikced() {
        openOrNot.toggle()
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func chevronButtonClicked(_ sender: UIButton) {
        
        openOrNot.toggle()
        CastTableView.reloadSections(IndexSet(0...0), with: .automatic)
        
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        
        } else {
            
        return tvShowInformation.tvShow.count
        
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let overviewCell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier, for: indexPath) as? OverViewTableViewCell else { return UITableViewCell() }
            
            overviewCell.overviewLabel.text = tvShowData?.overview ?? "줄거리 없음"
            
            if openOrNot == true {
                overviewCell.chevronButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
                overviewCell.overviewLabel.numberOfLines = 0
            } else {
                overviewCell.chevronButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            }
            
            return overviewCell
        
        } else {
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            
            castCell.actorImageView.backgroundColor = .gray
            castCell.actorImageView.layer.cornerRadius = 3
            castCell.actorImageView.contentMode = .scaleAspectFill
            
            castCell.nameLabel.text = "배우 이름"
            
            castCell.realNamelabel.text = "정보 없음"
            castCell.realNamelabel.textColor = .lightGray
            
            return castCell
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            if openOrNot == false {
                return UIScreen.main.bounds.height / 10
            } else {
                return tableView.estimatedRowHeight
            }
        } else {
            return UIScreen.main.bounds.height / 10
        }
    
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

}
