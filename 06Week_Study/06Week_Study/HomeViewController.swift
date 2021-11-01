//
//  ViewController.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/01.
//

import UIKit

class HomeViewVontroller: UIViewController {

    @IBOutlet weak var plusBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItemSetting()
     
    }
    
    func navigationItemSetting() {
    
        title = "HOME"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusBarButtonClicked))
        
    }
    
    @objc func plusBarButtonClicked() {
        
        let sb = UIStoryboard(name: "Home", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
        
    }
    
    

    
    
    
    

}
    

