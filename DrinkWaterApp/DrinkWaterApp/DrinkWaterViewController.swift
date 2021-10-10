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
        //잘못 알았던 거
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
        
        //위에 잘못 알았던거 해결하고 새로 짠 코드
        removeButton.image = UIImage(systemName: "arrow.clockwise")
        profileButton.image = UIImage(systemName: "person.circle")
        
        
        //Label UI
        topLabel.text = "잘하셨어요!\n오늘 마신 양은"
        topLabel.numberOfLines = 2
        topLabel.textColor = .white
        topLabel.font = UIFont.systemFont(ofSize: 25)
        
        let sumWater = UserDefaults.standard.integer(forKey: "drinkWater2")
        middleLabel.text = "\(sumWater)ml"
        middleLabel.textColor = .white
        middleLabel.font = UIFont.boldSystemFont(ofSize: 40)
        
        bottomLabel.textColor = .white
        bottomLabel.font = UIFont.systemFont(ofSize: 15)
        
        waterTextField.backgroundColor = UIColor(displayP3Red: 75/255, green: 157/255, blue: 125/255, alpha: 1.0)
        waterTextField.borderStyle = .none
        waterTextField.textAlignment = .right
        waterTextField.font = UIFont.systemFont(ofSize: 30)
        waterTextField.textColor = .white
        waterTextField.text = "0"
        waterTextField.keyboardType = .numberPad
        
        muchWaterLabel.font = UIFont.systemFont(ofSize: 30)
        muchWaterLabel.textColor = .white
        muchWaterLabel.text = "ml"
        
        haveToDrinkLabel.textAlignment = .center
        haveToDrinkLabel.font = UIFont.systemFont(ofSize: 15)
        haveToDrinkLabel.textColor = .white
        
        drinkingButton.setTitle("물마시기", for: .normal)
        drinkingButton.tintColor = .black
        
        
    }
    
    //viewDidLoad는 처음에 킬 때 한 번만 호출되지 않으므로 닉네임이 프로필에서 수정을 해도 바로 반영이 안됨. 화면 전환마다 켜지는 viewWillAppear로 구현.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        let haveToDrink = UserDefaults.standard.double(forKey: "water")
        var nickname = UserDefaults.standard.string(forKey: "nickname")
        
        if nickname == nil {
            nickname = "아무개"
        }
        
        haveToDrinkLabel.text = "\(nickname!)님의 하루 물 권장 섭취량은 \(haveToDrink)L 입니다."
        
        let percent = percentCalculating()
        bottomLabel.text = "목표의 \(percent)%"
        
        cactusImageAndLabelColorChange()
        
    }
    
    // 아까 위에 잘못 알았던 거 연장선
//    @objc func profiletapButton() {
//
//        // 인스턴스 타입을 전달해줘야 함. 요런 식으로
//         let vc = ProfileViewController()
//        navigationController?.pushViewController(vc, animated: true)
//
//    }

    
    // 퍼센트 계산 함수
    func percentCalculating() -> Int {
        
        var water = UserDefaults.standard.double(forKey: "water")
        
        //UserDefaults 초기값 관련 조건문
        if water == 0.0 {
            water = 0.001
        }
        
        let sumWater = UserDefaults.standard.integer(forKey: "drinkWater2")
        let percent = Double(sumWater) / (water * 1000)
        let result = Int(round(percent * 100))
        
        UserDefaults.standard.set(result, forKey: "percent")
        
        let updatePercent = UserDefaults.standard.integer(forKey: "percent")
        
        return(updatePercent)
        
    }
    
    func cactusImageAndLabelColorChange() {
        
        let percent = percentCalculating()
        
        if percent <= 10 {
            cactusImageView.image = UIImage(named: "1-1")
        } else if percent <= 20 {
            cactusImageView.image = UIImage(named: "1-2")
        } else if percent <= 30 {
            cactusImageView.image = UIImage(named: "1-3")
        } else if percent <= 40 {
            cactusImageView.image = UIImage(named: "1-4")
        } else if percent <= 50 {
            cactusImageView.image = UIImage(named: "1-5")
        } else if percent <= 60 {
            cactusImageView.image = UIImage(named: "1-6")
        } else if percent <= 70 {
            cactusImageView.image = UIImage(named: "1-7")
        } else if percent <= 80 {
            cactusImageView.image = UIImage(named: "1-8")
        } else if percent > 80 {
            cactusImageView.image = UIImage(named: "1-9")
        }
        
        if percent >= 100 {
            topLabel.textColor = .blue
            topLabel.text = "목표를 달성하셨어요!\n오늘 마신 양은"
            middleLabel.textColor = .blue
            bottomLabel.textColor = .blue
        }
    }
    
    @IBAction func tapGestureClikced(_ sender: UITapGestureRecognizer) {
        
        view.endEditing(true)
        
    }
    
    @IBAction func drinkButtonClicked(_ sender: UIButton) {
        
        UserDefaults.standard.set(waterTextField.text, forKey: "drinkWater1")
        let drinkWater = UserDefaults.standard.integer(forKey: "drinkWater1")
        let drinkWater2 = UserDefaults.standard.integer(forKey: "drinkWater2")
        
        UserDefaults.standard.set(drinkWater + drinkWater2, forKey: "drinkWater2")
        
        let updateDrinkWater = UserDefaults.standard.integer(forKey: "drinkWater2")
        
        let percent = percentCalculating()
        
        bottomLabel.text = "목표의 \(percent)%"
        middleLabel.text = "\(updateDrinkWater)ml"
        
        cactusImageAndLabelColorChange()
        
    }
    
    //초기화 버튼 클릭
    @IBAction func removeButtonClicked(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "drinkWater1")
        UserDefaults.standard.removeObject(forKey: "drinkWater2")
        UserDefaults.standard.removeObject(forKey: "percent")
        
        topLabel.text = "잘하셨어요!\n오늘 마신 양은"
        topLabel.textColor = .white
        middleLabel.text = "0ml"
        middleLabel.textColor = .white
        bottomLabel.text = "목표의 0%"
        bottomLabel.textColor = .white
        cactusImageView.image = UIImage(named: "1-1")
        
    }
    
    
}


// 초기화 버튼 눌렀을 때 정보 올 초기화 한번에

// 다만들고 앱삭제해서 첨부터 다시 구동해보기

// 시뮬레이터 상에서 버튼하나 잘못눌렀더니 시뮬레이터상에서 아예 앱도 안보이고 재설치도 안된다ㅠㅠ.. -> 해결


//보완점
//키와 몸무게 설정에 따른 값을 받아와서 메인화면에서 값을 설정해주는 과정 코드 구현이 너무 오래 걸렸다. 아직 Userdefault에 대한 심화된 이해가 필요.
//총 소요시간 : 14시간 (나중엔 줄겠지..)
//IQkeyboard 라이브러리 써볼랬는데 실패함. 방법 다시 찾아봐야할 듯.
//특정 기기에서는 UI가 깨짐. 특히 레이블 부분(adjustsFontSizeToFitWidth로 어느정도 해결 가능할듯)
//Userdefault의 초기값 문제 해결때문에 애먹음. integer는 0, Double은 0.0, String은 nil이다.
//네비게이션바 하단 보더 라인은 도저히 어떻게 만들어야 할지 모르겠다. 구글링해도 보더라인 없애는 것만 나오고 디폴트 값이 보더라인이 있는건가? 추후에 해결 필요.
//선인장 이미지 설정 관련 조건문이 너무 길어졌다. 조금 간략하게 할 수 있는 방법은 없을까.
//
