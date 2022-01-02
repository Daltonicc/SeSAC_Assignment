//
//  MainPostViewController.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/03.
//

import Foundation
import UIKit

class MainBoardViewController: UIViewController {
    
    let mainView = MainBoardView()
    let viewModel = MainBoardViewModel()
    
    override func loadView() {
        
        self.view = mainView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getBoardData {
            DispatchQueue.main.async {
                self.mainView.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
        mainView.tableView.register(MainBoardTableViewCell.self, forCellReuseIdentifier: MainBoardTableViewCell.identifier)
        
        navigationItem.title = "새싹농장"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension MainBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainBoardTableViewCell.identifier, for: indexPath) as? MainBoardTableViewCell else { return UITableViewCell() }
        
        
        return cell
    }
}


