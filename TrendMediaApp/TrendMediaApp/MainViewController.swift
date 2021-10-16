//
//  MainViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/16.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        buttonSetting()
        topViewSetting()
        navigationItemSetting()
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tvShowInformation.tvShow.count
    
    }
    
    
    //커스텀셀 디자인
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TvShowTableViewCell.identifier, for: indexPath) as? TvShowTableViewCell else {
            return UITableViewCell()
        }
        
        let row = tvShowInformation.tvShow[indexPath.row]
        
        cell.backgroundColor = UIColor(displayP3Red: 255/255, green: 222/255, blue: 222/255, alpha: 1.0)
        
        cell.showView.layer.cornerRadius = 10
        cell.showView.backgroundColor = UIColor(displayP3Red: 255/255, green: 222/255, blue: 222/255, alpha: 1.0)
        cell.showView.layer.shadowOpacity = 0.7
        cell.showView.layer.shadowRadius = 5
        cell.showView.layer.shadowColor = UIColor.gray.cgColor
        cell.showView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        cell.genreLabel.text = "#\(row.genre)"
        cell.genreLabel.textColor = .lightGray
        
        cell.titleLabel.text = row.title
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        
        cell.posterImageView.image = UIImage(named: row.title)
        cell.posterImageView.layer.cornerRadius = 10
        cell.posterImageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
//        cell.posterImageView.clipsToBounds = true
        

        cell.subRateLabel.text = "예상"
        cell.subRateLabel.textAlignment = .center
        cell.subRateLabel.backgroundColor = .orange
        
        cell.rateLabel.text = "\(row.rate)"
        cell.rateLabel.textAlignment = .center
        cell.rateLabel.backgroundColor = .white
        
        cell.koreanTitleLabel.text = row.koreanTitle
        cell.koreanTitleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        cell.releaseLabel.text = row.releaseDate
        cell.releaseLabel.textColor = .lightGray
        
        
        return cell
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
        
    }
    
    func navigationItemSetting() {
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .gray
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(searchButtonClicked))
        
    }
    
    @objc func searchButtonClicked(_ sender: UIBarButtonItem) {
        
        
        
    }
    
}

//보완점

//이미지 크기가 너무 큰데 어떻게 조절해야하지
