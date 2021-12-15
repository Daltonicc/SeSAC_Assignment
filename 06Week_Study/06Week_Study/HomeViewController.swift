//
//  ViewController.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/01.
//

import UIKit

class HomeViewVontroller: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let array = [
        Array(repeating: "a", count: 20),
        Array(repeating: "b", count: 13),
        Array(repeating: "c", count: 30),
        Array(repeating: "d", count: 13),
        Array(repeating: "e", count: 22),
        Array(repeating: "f", count: 25),
        Array(repeating: "g", count: 21),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItemSetting()
     
    }
    
    func navigationItemSetting() {
    
        //탭바 타이틀인지, 네비게이션 타이틀인지 구분필요.
        title = "HOME"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(plusBarButtonClicked))
        
    }
    
    @objc func plusBarButtonClicked() {
        
        //1. Storyboard
        let sb = UIStoryboard(name: "Home", bundle: nil)
        //2. ViewController
        let vc = sb.instantiateViewController(withIdentifier: "AddViewController") as! AddViewController
        //3. NavigationController
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalTransitionStyle = .crossDissolve
        nav.modalPresentationStyle = .fullScreen
        
        self.present(nav, animated: true, completion: nil)
        
    }

}
    

extension HomeViewVontroller: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
    
        cell.categoryLabel.backgroundColor = .yellow
        //Pass Data
        cell.data = array[indexPath.row]
     
        cell.collectionView.backgroundColor = .lightGray
        cell.collectionView.tag = indexPath.row
        //딱딱 맞게끔 넘어가게 하기.(단, 디바이스 width 기준일 때)
//        cell.collectionView.isPagingEnabled = true
        //셀이 재사용될 때마다 콜렉션뷰도 리로딩 해줘야함.
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return indexPath.row == 1 ? 500 : 170
    }
    
}


