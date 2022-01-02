//
//  Board.swift
//  SeSACFarmApp
//
//  Created by 박근보 on 2022/01/03.
//

import Foundation

struct Board: Codable {
    let id: Int
    let username: String
    let text: String
    let createdAt, updatedAt: String
}
