//
//  MainPostViewModel.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/03.
//

import Foundation

class MainBoardViewModel {
    
    var token: String = UserDefaults.standard.string(forKey: "token") ?? ""
    
    func getBoardData(completion: @escaping () -> Void) {
        
        APIService.getPost(token: token) { boardData, error in
            
            guard let boardData = boardData else {
                return
            }

        }
    }
}
