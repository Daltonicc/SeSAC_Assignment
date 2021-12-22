//
//  WithStoryboardViewController.swift
//  RecommendBeerApp
//
//  Created by 박근보 on 2021/12/22.
//

import UIKit

class WithStoryboardViewController: UIViewController {

    
    @IBOutlet weak var beerImageView: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var beerInfoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beerInfoTableView.delegate = self
        beerInfoTableView.dataSource = self
        
        topViewConfig()
        
    }
    
    func topViewConfig() {
        
        beerImageView.image = UIImage(systemName: "star")
        
        topView.layer.cornerRadius = 10
        topView.backgroundColor = .white
        topView.layer.shadowOpacity = 0.3
        topView.layer.shadowRadius = 5
        topView.layer.shadowColor = UIColor.gray.cgColor
        topView.layer.shadowOffset = CGSize(width: 5, height: 5)
        
        titleLabel.text = "Title"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textAlignment = .center
        
        subtitleLabel.text = "SubTitle"
        subtitleLabel.font = .systemFont(ofSize: 17)
        subtitleLabel.textAlignment = .center
        
        contentTextView.isEditable = false
        contentTextView.font = .systemFont(ofSize: 16)
        
        moreButton.setTitle("more", for: .normal)
        moreButton.tintColor = .black
        moreButton.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        refreshButton.setImage(UIImage(systemName: "arrow.2.circlepath"), for: .normal)
        refreshButton.tintColor = .cyan
        refreshButton.layer.cornerRadius = 10
        refreshButton.layer.borderWidth = 2
        refreshButton.layer.borderColor = UIColor.cyan.cgColor
        
        shareButton.setTitle("Share BEER", for: .normal)
        shareButton.titleLabel?.font = .boldSystemFont(ofSize: 20)
        shareButton.tintColor = .black
        shareButton.backgroundColor = .cyan
        shareButton.layer.cornerRadius = 10
        shareButton.layer.borderWidth = 2
        shareButton.layer.borderColor = UIColor.cyan.cgColor
        
    }
    
    @IBAction func moreButtonClicker(_ sender: UIButton) {
    
    }
    
    @IBAction func refreshButtonClicked(_ sender: UIButton) {
    
    }
    
    @IBAction func shareButtonClicked(_ sender: UIButton) {
    
    }
    
}

extension WithStoryboardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BeerTableViewCell.identifier, for: indexPath) as? BeerTableViewCell else { return UITableViewCell() }
            
        cell.textLabel?.text = "sadas"
        
         
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Food - Pairing"
        } else {
            return ""
        }
    }
}
