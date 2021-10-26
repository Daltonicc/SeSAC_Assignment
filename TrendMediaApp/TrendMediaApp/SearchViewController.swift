//
//  SearchViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tvShowInformation = TvShowInformation()
    
    var movieData: [MovieModel] = []
    
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
        
        fetchMovieData()
        
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
    
    //네이버 영화 네트워크 통신
    func fetchMovieData() {
        
        if let query = "스파이더맨".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=15&start=1"
            
            let header: HTTPHeaders = [
                "X-Naver-Client-Id": "FBAeES11vzmYievJ_ocV",
                "X-Naver-Client-Secret": "DLjCcp4V3M"
            ]
            
            AF.request(url, method: .get, headers: header).validate().responseJSON { response in
                switch response.result {
                    
                case .success(let value):
                    let json = JSON(value)
                    print("JSON: \(json)")
                
                    for item in json["items"].arrayValue {
                        
                        //<b>, </b> 제거해주기
                        let title = item["title"].stringValue.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: "")
                        let image = item["image"].stringValue
                        let link = item["link"].stringValue
                        let userRating = item["userRating"].stringValue
                        let sub = item["subtitle"].stringValue
                        
                        
                        let data = MovieModel(titleData: title, imageData: image, linkData: link, userRatingData: userRating, subtitle: sub)
                        
                        self.movieData.append(data)
    
                    }
                    
                    print(self.movieData)
                    //중요! 리로드해줘야함. why? 테이블뷰 로딩속도보다 통신속도가 느리기때문!
                    self.searchTableView.reloadData()
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    
    }
    
    
    
    //테이블뷰 관련 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(movieData.count)
        return movieData.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell() }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        let row2 = movieData[indexPath.row]
        
        cell.backgroundColor = .black
        
        cell.leftImageView.image = UIImage(named: row.title)
        
        let imageurl = URL(string: row2.imageData)
        cell.leftImageView.kf.setImage(with: imageurl)
        
        cell.titleLabel.text = movieData[indexPath.row].titleData
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
