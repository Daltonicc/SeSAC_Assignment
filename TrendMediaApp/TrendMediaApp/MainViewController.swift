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
    
    var trendData: [trendModel] = []
    var genreData: [Int : String] = [:]
    
    
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
        
        
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=0ddf09d4942a5788f4b0857f6895c28c"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    
                    let title = item["title"].stringValue
                    let voteAverage = item["vote_average"].doubleValue
                    let overview = item["overview"].stringValue
                    let poster = item["poster_path"].stringValue
                    let posterUrl = "https://image.tmdb.org/t/p/original/\(poster)"
                    let releaseDate = item["release_date"].stringValue
                    
                    var genreList: [Any] = []

                    for i in 0..<item["genre_ids"].count {
                        
                        let genre = self.genreData[item["genre_ids"][i].intValue]!
                        genreList.append(genre)
                        
                    }
                    
                    let data = trendModel(title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate, poster: posterUrl, genre: genreList)
                    
                    self.trendData.append(data)
                    
                }
                
                self.MovieTableView.reloadData()
                print(self.trendData)
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    //테이블 뷰 관련 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trendData.count
    
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
        vc.tvshowdata = tvShowInformation.tvShow[selectButton.tag]
        
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
        let row = tvShowInformation.tvShow[indexPath.row]
        
        vc.tvShowData = row
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        print(#function)
        
    }
    
}

//보완점

//총 소요시간: 22시간
//메인화면 이미지가 너무 큰데 지금은 조절법을 모르겠다,, CSRect도 시도해보고 Frame도 해봤지만 실패. 해당 문제로 인해 각각의 셀크기가 이미지뷰 크기에 따라 모두 다 제각각임. 추후에 방법 알게되면 개선 필요.
// -> 개선완료 오토레이아웃에서 이미지의 width값과 height값을 준뒤 heightforRowAt으로 해결.
// SearchBar 상하단 보더 없애야함. -> SearchBar style -> minimal로 해결.
//코드로 바버튼 아이템에 이미지와 타이틀을 동시에 달 순 없나,,? 이미지 타이틀을 지정해줘봤으나 이미지만 뜨고 타이틀은 뜨지 않음.
//테이블뷰를 맨아래에서 위로 스크롤 하려고하면 아래부분에서 하얀색 배경이 자꾸 나타난다.
//view.backgroundColor 가 분명 gray인데 왜 하얀 화면이 있는거지;;?
//오토레이아웃 관련 추가학습이 필요하다. 좋은 기능들이 많은거 같은데 내가 역량이 부족해서 너무 한정적으로 쓰는 느낌이 강하다.

//맵뷰 필터기능 구현완료.
//특정 기기 오토레이아웃 체크완료(iPod touch 7세대, iPone SE)
//
