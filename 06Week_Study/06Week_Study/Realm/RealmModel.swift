//
//  RealmModel.swift
//  06Week_Study
//
//  Created by 박근보 on 2021/11/02.
//

import Foundation
import RealmSwift


//UserDiary: 테이블 이름
//@Persisted: 컬럼
class UserDiary: Object {
    
    @Persisted var diaryTitle: String //제목(필수)
    @Persisted var diaryContent: String? //내용(옵션)
    @Persisted var writeDate = Date() //작성 날짜(필수)
    @Persisted var registerDate = Date() //등록일(필수)
    @Persisted var favorite: Bool //즐겨찾기 기능(필수)
    
    // PK(필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(diaryTitle: String, diaryContent: String?, writeDate: Date, registerDate: Date) {
        self.init()
        
        self.diaryTitle = diaryTitle
        self.diaryContent = diaryContent
        self.writeDate = writeDate
        self.registerDate = registerDate
        self.favorite = false
    }

}
