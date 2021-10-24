//
//  BooksViewController.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/19.
//

import UIKit

class BooksViewController: UIViewController {
    
    let tvshowInformation = TvShowInformation()
    
    @IBOutlet weak var BookCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        BookCollectionView.delegate = self
        BookCollectionView.dataSource = self
        
        let nibName = UINib(nibName: BooksCollectionViewCell.identifier, bundle: nil)
        BookCollectionView.register(nibName, forCellWithReuseIdentifier: BooksCollectionViewCell.identifier)
        
        cellLayout()
    }
    
}

//콜렉션뷰 관련 세팅
extension BooksViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        tvshowInformation.tvShow.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksCollectionViewCell.identifier, for: indexPath) as? BooksCollectionViewCell else { return UICollectionViewCell() }

        let item = tvshowInformation.tvShow[indexPath.item]
        
        cell.backgroundColor = getRandomColor()
        cell.layer.cornerRadius = 20
        
        cell.titleLabel.text = item.title
        cell.titleLabel.textColor = .white
        cell.titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cell.titleLabel.numberOfLines = 0
        cell.titleLabel.adjustsFontSizeToFitWidth = true
        cell.titleLabel.textAlignment = .center
        
        cell.rateLabel.text = "\(item.rate)"
        cell.rateLabel.textColor = .white
        
        cell.posterImageView.image = UIImage(named: item.title)
        cell.posterImageView.layer.cornerRadius = 15
        cell.posterImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]

        return cell
    }
    
    func getRandomColor() -> UIColor {
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }

    func cellLayout() {
        
        let layout = UICollectionViewFlowLayout()
        
        let spacing: CGFloat = 10
        let width = UIScreen.main.bounds.width - (spacing * 3)
        layout.itemSize = CGSize(width: width / 2, height: (width / 2) * 1.1)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        layout.minimumLineSpacing = 10
        layout.scrollDirection = .vertical
        
        BookCollectionView.collectionViewLayout = layout
    }
}
