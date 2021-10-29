//
//  SearchViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit
import Alamofire
import SwiftyJSON

class SearchViewController: UIViewController {

    let tvShowInformation = TvShowInformation()
    
    var movieData: [MovieModel] = []
    
    var startPage = 1
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var showSearchBar: UISearchBar!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var searchTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showSearchBar.delegate = self
        
        
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.prefetchDataSource = self
        
        view.backgroundColor = .gray
        searchTableView.backgroundColor = .black
        
        topviewSetting()
        
//        fetchMovieData()
        
    }
    
    //상단 뷰 UI
    func topviewSetting() {
        
        topView.backgroundColor = .gray
                
        searchView.backgroundColor = .white
        searchView.layer.cornerRadius = 10
                
        showSearchBar.barTintColor = .systemGray
        showSearchBar.searchBarStyle = .minimal
        
        cancelButton.tintColor = .white
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    //네이버 영화 네트워크 통신
    func fetchMovieData(query: String) {
        
        //문자열을 컴퓨터가 알아들을 수 있는 언어로 바꿔주기
        if let query = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                
            let url = "https://openapi.naver.com/v1/search/movie.json?query=\(query)&display=10&start=\(startPage)"
            
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
    
}

//테이블뷰 관련 세팅

//셀이 화면에 보이기 전에 필요한 리소스를 미리 다운 받는 기능
extension SearchViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for indexPath in indexPaths {
            if movieData.count - 1 == indexPath.row {
                startPage += 10
                fetchMovieData(query: "스파이더맨")
            }
        }
        
    }
    
    //화면을 엄청 빨리 스크롤할 때, 취소 용도
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("취소:\(indexPaths)")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(movieData.count)
        return movieData.count
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else {
            return UITableViewCell() }
        
        //코드 개선해야함!!
//        let row = tvShowInformation.tvShow[indexPath.row]
        let row2 = movieData[indexPath.row]
        
        cell.backgroundColor = .black
        
//        cell.leftImageView.image = UIImage(named: row.title)
        
        if let imageurl = URL(string: row2.imageData) {
        cell.leftImageView.kf.setImage(with: imageurl)
        } else { cell.leftImageView.image = UIImage(systemName: "star")}
        
        cell.titleLabel.text = movieData[indexPath.row].titleData
        cell.titleLabel.textColor = .white
        cell.titleLabel.numberOfLines = 0
        
//        cell.releaseDateLabel.text = "\(row.releaseDate) | \(row.region)"
//        cell.releaseDateLabel.textColor = .systemGray2
//
//        cell.overviewLabel.text = row.overview
//        cell.overviewLabel.textColor = .gray
//        cell.overviewLabel.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UIScreen.main.bounds.height / 6
    }
    
}

//서치바 관련 세팅
extension SearchViewController: UISearchBarDelegate {
    
    
    //검색 이후 자연스럽게 테이블뷰 드래그할 때 키보드 내리기 - 테이블뷰 인스펙터 - 스크롤뷰 관련 에서 키보드 조절
    //검색 버튼을 눌렀을 때 실행
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        
        if let text = searchBar.text {
            //기존의 데이터를 모두 지우고 새로운 데이터를 받아줌.
            movieData.removeAll()
            startPage = 1
            fetchMovieData(query: text)
            
        }
        
    }
    
    //취소 버튼 눌렀을 때 실행
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
//        searchBar.showsCancelButton = false
        movieData.removeAll()
        //extension으로 테이블뷰 관련 메서드 빼주기
//        tableView.reloadData()
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    //서치바에 커서 깜빡이기 시작할 떄
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(#function)
//        searchBar.showsCancelButton = true
        //애니메이션 효과로 cancel버튼 만들어주고 싶을 때
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    //텍스트가 하나씩 쳐질때마다 검색(실시간 검색)
    //문제점 1. 과도한 호출이 생김.
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
    
    
}
