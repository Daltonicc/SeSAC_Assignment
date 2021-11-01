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
        
        leftButton.leftbuttonSetting()
        middleButton.middleButtonSetting()
        rightButton.rightButtonSetting()
        
        topImageView.topImageViewSetting()
        topView.topButtonViewSetting()
        veryTopLabel.veryTopLabelSetting()
        
        navigationItemSetting()
        
        MainAPIManager.shared.getGenreData()
        MainAPIManager.shared.getMovieData { json in
            
            self.MovieTableView.reloadData()
        }
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
    
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    //테이블 뷰 관련 세팅
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainAPIManager.shared.trendData.count
    
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        //마지막 셀을 볼 때 새로운 데이터를 받아와 줌.
        for indexPath in indexPaths {
            if MainAPIManager.shared.trendData.count - 1 == indexPath.row {
                MainAPIManager.shared.startPage += 1
                MainAPIManager.shared.getMovieData { json in
                    self.MovieTableView.reloadData()
                }
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
        
        let trendRow = MainAPIManager.shared.trendData[indexPath.row]
        
        cell.backgroundColor = UIColor(displayP3Red: 255/255, green: 222/255, blue: 222/255, alpha: 1.0)
        
        cell.showView.showViewSetting()
        
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
        cell.posterImageView.posterImageViewSetting()
        
        //버튼에 태그 부여.
        cell.webButton.tag = indexPath.row
        cell.webButton.addTarget(self, action: #selector(webButtonClicked), for: .touchUpInside)
        cell.webButton.webButtonSetting()

        cell.subRateLabel.subRateLabelSetting()
        
        cell.rateLabel.text = "\(trendRow.voteAverage)"
        cell.rateLabel.rateLabelSetting()
        
        cell.koreanTitleLabel.text = trendRow.title
        cell.koreanTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        cell.releaseLabel.text = trendRow.releaseDate
        cell.releaseLabel.textColor = .lightGray
        
        return cell
    }
    
    @objc func webButtonClicked(selectButton: UIButton) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        //Pass Data.
        vc.trendData = MainAPIManager.shared.trendData[selectButton.tag]
        
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
        let trendRow = MainAPIManager.shared.trendData[indexPath.row]
        
        vc.trendData = trendRow
        
        self.navigationController?.pushViewController(vc, animated: true)
        
        print(#function)
        
    }
    
}
//가끔씩 네트워크 통신 순서 문제인지 모르겠으나 장르 데이터를 먼저 받아오지 않음.
//장르 데이터를 받아와서 장르 딕셔너리를 만듦 -> 영화 데이터(장르 넘버)를 받아와서 장르 레이블에 장르를 표시함.
//요 순서대로 가야하는데 가끔 시뮬을 50번 중에 한 2~3번정도는 영화 데이터를 먼저 받아오고 장르 데이터를 받아오는 바람에 뷰에 장르가 표시가 되지 않음. 코드상으로는 장르데이터를 먼저 받게끔 했음

//익스텐션의 적정량이 있나? 각 UI별 모든 익스텐션을 만들어도 되는 것인지.
