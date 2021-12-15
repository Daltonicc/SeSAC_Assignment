//: [Previous](@previous)

import Foundation
import Security
import Darwin

//영진원API: 20211021, "", "문자", "20211333"

func checkDateFormat(text: String) -> Bool {
    
    let format = DateFormatter()
    format.dateFormat = "yyyymmdd"
    return format.date(from: text) == nil ? false : true
    
}

func validateUserInput(text: String) -> Bool {
    //사용자가 입력한 값이 빈 값일 경우
    guard !(text.isEmpty) else {
        print("빈 값입니다")
        return false
    }
    
    //사용자가 입력한 값이 숫자인지 아닌지
    guard Int(text) != nil else {
        print("숫자가 아닙니다")
        return false
    }
    
    //사용자가 입력한 값이 날짜 형태로 변환이 되는 숫자인지 아닌지
    guard checkDateFormat(text: text) else {
        print("날짜 형태가 아닙니다")
        return false
    }
    
    return true
    
}

if validateUserInput(text: "20220000") {
    print("검색을 할 수 있음")
} else {
    print("검색을 할 수 없음")
}

//-------------------------
//오류 처리 패턴: do try catch / Error Protocol
//컴파일러가 오류 타입을 인정.
enum ValidationError: Error {
    case emptyString = 401
    case invalidInt = 402
    case invalidDate = 403
}

func validateUserInputError(text: String) throws -> Bool {
    
    guard !(text.isEmpty) else {
        throw ValidationError.emptyString
    }
    
    guard Int(text) != nil else {
        throw ValidationError.invalidInt
    }
    
    guard checkDateFormat(text: text) else {
        throw ValidationError.invalidDate
    }
    
    return true
}

do {
    let result = try validateUserInputError(text: "20211101")

    print(result, "성공")
} catch ValidationError.emptyString {
    print("값 비었음")
} catch ValidationError.invalidInt {
    print("노 숫자")
} catch ValidationError.invalidDate {
    print("노 날짜") // ValidtionError.invaildDate.rawValue
}


//: [Next](@next)
