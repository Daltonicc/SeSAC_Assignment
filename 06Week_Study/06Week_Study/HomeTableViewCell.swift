//
//  HomeTableViewCell.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/08.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    static let identifier = "HomeTableViewCell"
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data: [String] = [] {
        //프로퍼티 감시자 활용. 데이터의 값이 바뀔때마다 리로드할 수 있게
        didSet {
            collectionView.reloadData()
            categoryLabel.text = "\(data.count)개"
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HomeTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.identifier, for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        
        cell.imageView.backgroundColor = .brown
        
        cell.contentLabel.text = data[indexPath.row]
        cell.contentLabel.textColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //테이블뷰 셀의 인덱스패스를 어떻게 가지고 와야할까
        if collectionView.tag == 0 {
            return CGSize(width: UIScreen.main.bounds.width, height: 100)
        } else {
            return CGSize(width: 150, height: 150)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        //여백 주기
        if collectionView.tag == 0 {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        } else {
            return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionView.tag == 0 ? 0 : 10

    }
}
