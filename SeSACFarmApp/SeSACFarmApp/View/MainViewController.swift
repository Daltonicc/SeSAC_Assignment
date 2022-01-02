//
//  ViewController.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/01.
//

import UIKit

class MainViewController: UIViewController {

    let mainView = MainView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
    }


}

