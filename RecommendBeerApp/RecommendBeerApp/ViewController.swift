//
//  ViewController.swift
//  RecommendBeerApp
//
//  Created by 박근보 on 2021/12/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let label = UILabel()
    
    let headerView = UIView()
    
    let beerImageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    let informationView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.black.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textAlignment = .center
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19)
        label.textAlignment = .center
        return label
    }()
    
    let infoTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 18)
        textView.isEditable = false
        return textView
    }()
    
    let moreInfoButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "more"
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        view.addSubview(tableView)
        tableViewConfigure()
        headerViewConfigure()
        
        
    }
    
    func tableViewConfigure() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view).offset(0)
            $0.centerX.equalTo(view)
            $0.width.equalTo(view.snp.width)
            $0.bottom.equalTo(view).offset(-100)
//            $0.edges.equalToSuperview()
        }
    }
    
    func headerViewConfigure() {
        
        headerView.backgroundColor = .brown

        headerView.addSubview(beerImageView)
        headerView.addSubview(informationView)

        beerImageView.backgroundColor = .orange
        beerImageView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.top)
            $0.leading.trailing.equalTo(headerView)
            $0.bottom.equalTo(headerView.snp.bottom).inset(200)
        }
        beerImageView.image = UIImage(systemName: "star")
        
        
        informationView.backgroundColor = .yellow
        informationView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.top).inset(300)
            $0.leading.trailing.equalTo(headerView).inset(30)
            $0.bottom.equalTo(headerView.snp.bottom)
        }
        
//        informationView.addSubview(titleLabel)
//        informationView.addSubview(subtitleLabel)
//        informationView.addSubview(infoTextView)
//        informationView.addSubview(moreInfoButton)
        

    }
    
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "sdsds"
        if indexPath.row == 1 {
            cell.addSubview(informationView)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return 50
    
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 400
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        return headerView
    }
}


