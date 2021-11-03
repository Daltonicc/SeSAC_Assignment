import UIKit

//기본 클로저

func heightPlusWeight(ht: Int, wt:Int) -> Int {
    return ht + wt
}


func someoneData(name: String, age:Int, height: Int, weight: Int, body:(Int, Int) -> Int) -> String {
    
    let bodyStatus = body(height, weight)
    let answer = "\(name)님의 나이는 \(age)이며, 신체 상태는 \(bodyStatus)입니다."
    
    return answer
    
}

let park = someoneData(name: "Park", age: 20, height: 180, weight: 70, body: heightPlusWeight)

let kim = someoneData(name: "Kim", age: 21, height: 160, weight: 50) { (a:Int, b:Int) -> Int in
    return a + b
}

//매개변수의 타입 생략
let kim2 = someoneData(name: "Kim", age: 21, height: 160, weight: 50) { (a, b) -> Int in
    return a + b
}

//반환타입, 소괄호 생략
let kim3 = someoneData(name: "Kim", age: 21, height: 160, weight: 50) { a, b in
    return a + b
}

//return 생략
let kim4 = someoneData(name: "Kim", age: 21, height: 160, weight: 50) { a, b in
    a + b
}

//in 생략, 단축인자 사용
let kim5 = someoneData(name: "Kim", age: 21, height: 160, weight: 50) { $0 + $1 }

