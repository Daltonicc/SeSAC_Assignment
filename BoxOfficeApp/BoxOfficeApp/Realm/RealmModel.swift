//
//  RealmModel.swift
//  BoxOfficeApp
//
//  Created by 박근보 on 2021/11/03.
//

import Foundation
import RealmSwift

class BoxOfficeList: Object {
    
    @Persisted var date: String
    @Persisted var rank: String
    @Persisted var title: String
    @Persisted var releaseDate: String

    @Persisted(primaryKey: true) var _id: ObjectId

    convenience init(date: String, rank: String, title: String, releaseDate: String) {
        self.init()
        
        self.date = date
        self.rank = rank
        self.title = title
        self.releaseDate = releaseDate
        
    }
}
