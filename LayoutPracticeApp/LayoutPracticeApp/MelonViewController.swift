//
//  MelonViewController.swift
//  LayoutPracticeApp
//
//  Created by 박근보 on 2021/12/15.
//

import UIKit

class MelonViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "strawberry moon"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    let authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "아이유"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    let titleSideButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        return button
    }()
    let authorSideButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
        return button
    }()
    
    let albumImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "strawberrymoonalbumcover")
        return image
    }()
    
    let favoriteButton: UIButton = {
        let button = UIButton()
        button.tintColor = .lightGray
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        return button
    }()
    
    let favoriteNumberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "101,354"
        label.textAlignment = .center
        return label
    }()
    
    let similarSongButton: UIButton = {
        let button = UIButton()
        button.setTitle("유사곡", for: .normal)
        button.tintColor = .lightGray
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    let instaLinkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "triplogo"), for: .normal)
        return button
    }()
    
    let lyricsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.text = "달이 익어가니 서둘러 젊은 피야\n민들레 한 송이 들고"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let repeatButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "repeat"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    let progressImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "progressimage")
        return image
    }()
    let repeatOptionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.2.squarepath"), for: .normal)
        button.tintColor = .lightGray
        return button
    }()
    
    let songListButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "text.chevron.right"), for: .normal)
        button.tintColor = .white
        return button
    }()
    let backSongButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    let pauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    let nextSongButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = .white
        return button
    }()
    let eQButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "volume"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        
        let list = [titleLabel, authorLabel, titleSideButton, authorSideButton, albumImageView/*, favoriteButton, favoriteNumberLabel, similarSongButton, instaLinkButton, lyricsLabel, repeatButton, progressImageView, repeatOptionButton, songListButton, backSongButton, pauseButton, nextSongButton, eQButton*/]
        list.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        constraintsSetting()
    }
    
    func constraintsSetting() {
        
        NSLayoutConstraint.activate([
        
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 20),
        
            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            authorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            authorLabel.heightAnchor.constraint(equalToConstant: 15),
            
            titleSideButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleSideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            titleSideButton.heightAnchor.constraint(equalToConstant: 20),
            titleSideButton.widthAnchor.constraint(equalToConstant: 20),
            
            authorSideButton.topAnchor.constraint(equalTo: titleSideButton.bottomAnchor, constant: 10),
            authorSideButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            authorSideButton.heightAnchor.constraint(equalToConstant: 20),
            authorSideButton.widthAnchor.constraint(equalToConstant: 20),
            
            albumImageView.
            
        ])
    }
    
}
