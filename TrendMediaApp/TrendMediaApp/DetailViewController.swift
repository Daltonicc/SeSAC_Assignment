//
//  DetailViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit
import Kingfisher
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tvShowInformation = TvShowInformation()
    var tvShowData: TvShow?
    var trendData: TrendModel?
    var castData: [CastModel] = []
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
        getCastCrewData()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: self, action: #selector(backButtonClikced))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationItem.title = "출연/제작"
        
    }
    
    func headerViewSetting() {
        let backdropUrl = URL(string: trendData?.backdropImage ?? "https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg")
        
        let posterUrl = URL(string: trendData?.poster ?? "https://www.themoviedb.org/t/p/original/oaGvjB0DvdhXhOAuADfHb261ZHa.jpg")
        
        headerImageView.kf.setImage(with: backdropUrl)
        headerImageView.contentMode = .scaleAspectFill
        
        headerSmallImageView.kf.setImage(with: posterUrl)
        headerSmallImageView.contentMode = .scaleAspectFill
        
        headerImageNameLabel.text = trendData?.title ?? "내용 없음"
        headerImageNameLabel.textColor = .white
        headerImageNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
    }
    
    @objc func backButtonClikced() {
        openOrNot.toggle()
        self.navigationController?.popViewController(animated: true)
    
    }
    
    @IBAction func chevronButtonClicked(_ sender: UIButton) {
        
        openOrNot.toggle()
        CastTableView.reloadSections(IndexSet(0...0), with: .automatic)
        
    }

    func getCastCrewData() {
        
        let url = "https://api.themoviedb.org/3/movie/\(trendData!.moiveid)/credits?api_key=0ddf09d4942a5788f4b0857f6895c28c&language=en-US"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["cast"].arrayValue {
                    
                    let name = item["name"].stringValue
                    let character = item["character"].stringValue
                    
                    let image = item["profile_path"].stringValue
                    let imageUrl = "https://image.tmdb.org/t/p/original/\(image)"
                    
                    let data = CastModel(name: name, character: character, image: imageUrl)
                    
                    self.castData.append(data)
                }
                
                self.CastTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //테이블뷰 관련 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 1
        
        } else {
            
            return castData.count
        
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        if indexPath.section == 0 {
            guard let overviewCell = tableView.dequeueReusableCell(withIdentifier: OverViewTableViewCell.identifier, for: indexPath) as? OverViewTableViewCell else { return UITableViewCell() }
            
            overviewCell.overviewLabel.text = trendData?.overview ?? "줄거리 없음"
            
            if openOrNot == true {
                overviewCell.chevronButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
                overviewCell.overviewLabel.numberOfLines = 0
            } else {
                overviewCell.chevronButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            }
            
            return overviewCell
        
        } else {
            guard let castCell = tableView.dequeueReusableCell(withIdentifier: CastTableViewCell.identifier, for: indexPath) as? CastTableViewCell else { return UITableViewCell() }
            
            let castRow = castData[indexPath.row]
            
            let actorImage = URL(string: castRow.image)
            
            castCell.actorImageView.kf.setImage(with: actorImage)
            castCell.actorImageView.backgroundColor = .gray
            castCell.actorImageView.layer.cornerRadius = 3
            castCell.actorImageView.contentMode = .scaleAspectFill
            
            
            castCell.nameLabel.text = castRow.name
            
            castCell.realNamelabel.text = castRow.character
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
