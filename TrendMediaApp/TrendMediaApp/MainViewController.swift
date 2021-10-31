//
//  MainViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class MainViewController: UIViewController {
    
    let tvShowInformation = TvShowInformation()
    
    var trendData: [TrendModel] = []
    var genreData: [Int : String] = [:]
    
    var startPage = 1
    
    @IBOutlet weak var veryTopLabel: UILabel!
    @IBOutlet weak var MovieTableView: UITableView!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var middleButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieTableView.delegate = self
        MovieTableView.dataSource = self
        MovieTableView.prefetchDataSource = self
        MovieTableView.backgroundColor = UIColor(displayP3Red: 255/255, green: 222/255, blue: 222/255, alpha: 1.0)
        
        buttonSetting()
        topViewSetting()
        navigationItemSetting()
    
        
        getGenreData()
        getMovieData()
        
        
    }
    
    //button UI
    func buttonSetting() {
        
        //인스펙터에서 버튼 스타일 디폴트 줘야함
        leftButton.setImage(UIImage(systemName: "film"), for: .normal)
        leftButton.contentHorizontalAlignment = .fill
        leftButton.contentVerticalAlignment = .fill
        leftButton.tintColor = .systemGreen
        
        
        middleButton.setImage(UIImage(systemName: "tv"), for: .normal)
        middleButton.contentVerticalAlignment = .fill
        middleButton.contentHorizontalAlignment = .fill
        middleButton.tintColor = .systemOrange
        
        rightButton.setImage(UIImage(systemName: "book.closed"), for: .normal)
        rightButton.contentVerticalAlignment = .fill
        rightButton.contentHorizontalAlignment = .fill
        rightButton.tintColor = .systemBlue
        
    }
    
    //topview UI
    func topViewSetting() {
        
        topImageView.image = UIImage(named: "A Tale Dark & Grimm")
        topImageView.contentMode = .scaleAspectFill
        
        topView.layer.shadowOpacity = 0.7
        topView.layer.shadowRadius = 5
        topView.layer.shadowColor = UIColor.gray.cgColor
        topView.layer.shadowOffset = CGSize(width: 5, height: 5)
        topView.layer.cornerRadius = 10
        
        veryTopLabel.text = "OH PARK!"
        veryTopLabel.font = .boldSystemFont(ofSize: 40)
        veryTopLabel.textAlignment = .center
        veryTopLabel.textColor = .white
        veryTopLabel.adjustsFontSizeToFitWidth = true
        
    }
    
    func navigationItemSetting() {
        
        let firstLeftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        firstLeftBarButtonItem.tintColor = .black
        
        let secondLeftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "mappin.circle"), style: .plain, target: self, action: #selector(mapButtonClicked(_:)))
        secondLeftBarButtonItem.tintColor = .black
        
        let barButtonList = [firstLeftBarButtonItem, secondLeftBarButtonItem]
        
        
        navigationItem.leftBarButtonItems = barButtonList
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        navigationItem.rightBarButtonItem?.tintColor = .black
        
    }
    
    @objc func mapButtonClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        //1. 스토리보드 지정
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        //2. 스토리보드 안에 어떤 뷰컨트롤러로 가게 할지.
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        
        //3. Present
        self.present(vc, animated: true, completion: nil)
    
    }
    
    func getGenreData() {
        
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=0ddf09d4942a5788f4b0857f6895c28c&language=en-US"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //장르 딕셔너리에 담아주기
                for item in json["genres"].arrayValue {
                    
                    let genreid = item["id"].intValue
                    let genrename = item["name"].stringValue
                    
                    self.genreData.updateValue(genrename, forKey: genreid)
                    
                }
                
            case .failure(let error):
                print(error)
            }
        }
        
        
    }
    
    //TMDB 트렌딩 네트워크 통신
    func getMovieData() {
        
        // 혹시 TMDB movie데이터 받아올 때 항상 1페이지만 받아오는데 다음페이지 받아오게 어떻게 하셨나요?? 네이버 영화검색은 url에 start페이지 적는 부분이 있었는데 TMDB는 따로없네요;;=
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=0ddf09d4942a5788f4b0857f6895c28c&page=\(startPage)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    
                    let title = item["title"].stringValue
                    let voteAverage = item["vote_average"].doubleValue
                    let overview = item["overview"].stringValue
                    
                    let backdropImage = item["backdrop_path"].stringValue
                    let backdropUrl = "https://image.tmdb.org/t/p/original/\(backdropImage)"
                    
                    let poster = item["poster_path"].stringValue
                    let posterUrl = "https://image.tmdb.org/t/p/original/\(poster)"
                    
                    
                    let releaseDate = item["release_date"].stringValue
                    let movieid = item["id"].intValue
                    
                    var genreList: [Any] = []

                    for i in 0..<item["genre_ids"].count {
                        
                        if let genre = self.genreData[item["genre_ids"][i].intValue] {
                            
                            genreList.append(genre)
                        }
                        
                        
                    }
                    
                    let data = TrendModel(title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate, poster: posterUrl, backdropImage: backdropUrl ,genre: genreList, moiveid: movieid)
                    
                    self.trendData.append(data)
                    
                }
                
                self.MovieTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    //테이블 뷰 관련 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendData.count
    
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        //마지막 셀을 볼 때 새로운 데이터를 받아와 줌.
        for indexPath in indexPaths {
            if trendData.count - 1 == indexPath.row {
                startPage += 1
                getMovieData()
                print(#function)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
        
    }

    //커스텀셀 디자인
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvShowTableViewCell.identifier, for: indexPath) as? TvShowTableViewCell else {
            return UITableViewCell()
        }
        
        
        let trendRow = trendData[indexPath.row]
        
        cell.backgroundColor = UIColor(displayP3Red: 255/255, green: 222/255, blue: 222/255, alpha: 1.0)
        
        cell.showView.layer.cornerRadius = 10
        cell.showView.backgroundColor = UIColor(displayP3Red: 255/255, green: 222/255, blue: 222/255, alpha: 1.0)
        cell.showView.layer.shadowOpacity = 0.7
        cell.showView.layer.shadowRadius = 5
        cell.showView.layer.shadowColor = UIColor.gray.cgColor
        cell.showView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        cell.genreLabel.text = ""
        for i in 0..<trendRow.genre.count {
            cell.genreLabel.text! += " #\(trendRow.genre[i])"
        }
        cell.genreLabel.textColor = .lightGray
        
        cell.titleLabel.text = trendRow.title
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        if let imageurl = URL(string: trendRow.poster) {
        cell.posterImageView.kf.setImage(with: imageurl)
        } else { cell.posterImageView.image = UIImage(systemName: "star")}
    
        cell.posterImageView.layer.cornerRadius = 10
        cell.posterImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        cell.webButton.setImage(UIImage(systemName: "paperclip"), for: .normal)
        cell.webButton.backgroundColor = .white
        cell.webButton.layer.cornerRadius = 15
        cell.webButton.tintColor = .black

        cell.subRateLabel.text = "예상"
        cell.subRateLabel.textAlignment = .center
        cell.subRateLabel.backgroundColor = .orange
        
        cell.rateLabel.text = "\(trendRow.voteAverage)"
        cell.rateLabel.textAlignment = .center
        cell.rateLabel.backgroundColor = .white
        
        cell.koreanTitleLabel.text = trendRow.title
        cell.koreanTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        cell.releaseLabel.text = trendRow.releaseDate
        cell.releaseLabel.textColor = .lightGray
        
        //버튼에 태그 부여.
        cell.webButton.tag = indexPath.row
        cell.webButton.addTarget(self, action: #selector(webButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func webButtonClicked(selectButton: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        //Pass Data.
        vc.tvshowData = tvShowInformation.tvShow[selectButton.tag]
        vc.trendData = trendData[selectButton.tag]
        
        let nav = UINavigationController(rootViewController: vc)
        
        self.present(nav, animated: true, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        //Pass Data.
//        let row = tvShowInformation.tvShow[indexPath.row]
        let trendRow = trendData[indexPath.row]
        
        vc.trendData = trendRow
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        print(#function)
        
    }
    
}

//가끔씩 네트워크 통신 순서 문제인지 모르겠으나 장르 데이터를 먼저 받아오지 않음.
//장르 데이터를 받아와서 장르 딕셔너리를 만듦 -> 영화 데이터(장르 넘버)를 받아와서 장르 레이블에 장르를 표시함.
//요 순서대로 가야하는데 가끔 시뮬을 50번 중에 한 2~3번정도는 영화 데이터를 먼저 받아오고 장르 데이터를 받아오는 바람에 뷰에 장르가 표시가 되지 않음. 코드상으로는 장르데이터를 먼저 받게끔 했음
