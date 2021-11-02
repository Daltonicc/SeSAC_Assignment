//
//  RealmModel.swift
//  ShoppingListApp
//
//  Created by 박근보 on 2021/11/02.
//

import Foundation
import RealmSwift

class ShoppingList: Object {
    
    @Persisted var shoppingContent: String
    @Persisted var favoriteStatus: Bool
    @Persisted var successStatus: Bool
    
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(shoppingContent: String, favoriteStatus: Bool, successStatus: Bool) {
        self.init()
        
        self.shoppingContent = shoppingContent
        self.favoriteStatus = favoriteStatus
        self.successStatus = successStatus
        
    }
}
