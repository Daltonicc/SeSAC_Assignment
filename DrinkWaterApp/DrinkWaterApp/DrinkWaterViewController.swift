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
    @IBOutlet var muchWaterLabel: UILabel!
    @IBOutlet var haveToDrinkLabel: UILabel!
    @IBOutlet var drinkingButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(displayP3Red: 75/255, green: 157/255, blue: 125/255, alpha: 1.0)
        
        //네비게이션 바 버튼 아이템 이미지 커스텀뷰
        //이미지 사이즈 좀만 더 크게 할 순 없나..
        let removebuttonImage = UIButton(type: .custom)
        removebuttonImage.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        removebuttonImage.tintColor = .white
        
        let profileButtonImage = UIButton(type: .custom)
        profileButtonImage.setImage(UIImage(systemName: "person.circle"), for: .normal)
        profileButtonImage.tintColor = .white

        removeButton.customView = removebuttonImage
        profileButton.customView = profileButtonImage
        
        //Label UI
        topLabel.text = "잘하셨어요!\n오늘 마신 양은"
        topLabel.numberOfLines = 2
        topLabel.textColor = .white
        topLabel.font = UIFont.boldSystemFont(ofSize: 25)
        
        //imageview UI
        cactusImageView.layer.cornerRadius = cactusImageView.bounds.width / 2
        cactusImageView.layer.masksToBounds = true
        
        muchWaterLabel.textAlignment = .center
        
        haveToDrinkLabel.textAlignment = .center
        
        drinkingButton.setTitle("물마시기", for: .normal)
        drinkingButton.tintColor = .black
        
    }
    


}
