//
//  DrinkWaterViewController.swift
//  DrinkWaterApp
//
//  Created by 박근보 on 2021/10/08.
//

//네비게이션 바 아래 보더라인 생성 어떻게?

import UIKit

class DrinkWaterViewController: UIViewController {

    @IBOutlet var removeButton: UIBarButtonItem!
    @IBOutlet var profileButton: UIBarButtonItem!
    @IBOutlet var topLabel: UILabel!
    @IBOutlet var middleLabel: UILabel!
    @IBOutlet var bottomLabel: UILabel!
    @IBOutlet var cactusImageView: UIImageView!
    @IBOutlet var waterTextField: UITextField!
    @IBOutlet var muchWaterLabel: UILabel!
    @IBOutlet var haveToDrinkLabel: UILabel!
    @IBOutlet var drinkingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: 75/255, green: 157/255, blue: 125/255, alpha: 1.0)
        
        //네비게이션 바 버튼 아이템 이미지 커스텀뷰
        //이미지 사이즈 좀만 더 크게 할 순 없나..
        //스토리보드에 바 버튼 아이템을 가져와서 넣어야 하는데 일반 버튼 넣어놓고 왜 안되냐고 하고있었음. 진짜 멍청했다. 그래도 코드로 하는 법 알았으니 만족,,
        
//        let removebuttonImage = UIButton(type: .custom)
//        removebuttonImage.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
//        removebuttonImage.tintColor = .white
//        removebuttonImage.addTarget(self, action: #selector(DrinkWaterViewController.viewDidLoad), for: .touchUpInside)
//
//        let profileButtonImage = UIButton(type: .custom)
//        profileButtonImage.setImage(UIImage(systemName: "person.circle"), for: .normal)
//        profileButtonImage.tintColor = .white
//        profileButtonImage.addTarget(self, action: #selector(profiletapButton), for: .touchUpInside)
        

//        removeButton.customView = removebuttonImage
//        profileButton.customView = profileButtonImage
        
        //새로 짠 코드
        removeButton.image = UIImage(systemName: "arrow.clockwise")
        profileButton.image = UIImage(systemName: "person.circle")
        
        
        //Label UI
        topLabel.text = "잘하셨어요!\n오늘 마신 양은"
        topLabel.numberOfLines = 2
        topLabel.textColor = .white
        topLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        //imageview UI
        cactusImageView.layer.cornerRadius = cactusImageView.bounds.width / 2
        cactusImageView.layer.masksToBounds = true
        
        
        waterTextField.backgroundColor = UIColor(displayP3Red: 75/255, green: 157/255, blue: 125/255, alpha: 1.0)
        waterTextField.borderStyle = .none
        waterTextField.textAlignment = .right
        waterTextField.font = UIFont.systemFont(ofSize: 25)
        waterTextField.textColor = .white
        
        muchWaterLabel.font = UIFont.systemFont(ofSize: 25)
        muchWaterLabel.textColor = .white
        muchWaterLabel.text = "ml"
        
        haveToDrinkLabel.textAlignment = .center
        haveToDrinkLabel.textColor = .white
        
        drinkingButton.setTitle("물마시기", for: .normal)
        drinkingButton.tintColor = .black
        
        
    }
    
    // 아까 위에 잘못 알았던 거 연장선
//    @objc func profiletapButton() {
//
//        // 인스턴스 타입을 전달해줘야 함. 요런 식으로
//         let vc = ProfileViewController()
//        navigationController?.pushViewController(vc, animated: true)
//
//    }


}
