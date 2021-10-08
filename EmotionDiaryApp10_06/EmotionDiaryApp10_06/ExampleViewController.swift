//
//  ExampleViewController.swift
//  EmotionDiaryApp10_06
//
//  Created by 박근보 on 2021/10/08.
//

import UIKit

enum GameJob {
    case rogue //도적
    case warrior //전사
    case mystic //도사
    case shaman //주술사
    case fight //격투가
}

class ExampleViewController: UIViewController {

    var selectJob: GameJob = .rogue
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        switch selectJob {
//        case .rogue:
//            print("도적")
//        case .warrior:
//            print(<#T##items: Any...##Any#>)
//        case .mystic:
//            print(<#T##items: Any...##Any#>)
//        case .shaman:
//            print(<#T##items: Any...##Any#>)
//        case .fight:
//            print(<#T##items: Any...##Any#>)
//        }
        
        view.backgroundColor = setViewBackground()
        
    }
    
    //1. 반환값의 타입을 옵셔널 타입으로 변경: UIColor -> UIColor?
    //2. 반환될 값을 옵셔널 강제 해제 random.randomElement()!
    //3. 반환될 값: ?? 로도 가능.
    func setViewBackground() -> UIColor {
        
        let random: [UIColor] = [.red, .black, .gray, .green]
        return random.randomElement() ?? UIColor.yellow
        
    }
    
    //option + command + <- = { 기준으로 축소
    @IBAction func showAlert(_ sender: UIButton) {
        
        //1. UIAlertController 생성: 밑바탕 + 타이틀 + 본문
        //타이틀과 메시지부분을 안쓰려면 nil값을 쓰면 됨.
        let alert = UIAlertController(title: "타이틀 테스트", message: "메시지가 입력되었습니다.", preferredStyle: .actionSheet)
        
        //2. UIAlertAction 생성: 버튼들..
        let ok = UIAlertAction(title: "아이폰겟!", style: .default)
        let ipad = UIAlertAction(title: "아이패드!", style: .cancel)
        let watch = UIAlertAction(title: "와치", style: .destructive)
        
        //3. 1+2
        alert.addAction(ok)
        alert.addAction(ipad)
        alert.addAction(watch)
        
        //컬러피커
//        let colorPicker = UIColorPickerViewController()
        
        
        //4. Present
        //present(colorPicker, animated: true, completion: nil)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    
}
