import UIKit


//class SeSacStudent {
//
//    var name: String
//
//    init(realname: String) {
//        self.name = realname
//    }
//
//}
//
//let student1 = SeSacStudent(realname: "Park")
//print(student1.name)
//
//
//struct SSacStudent {
//
//    var name: String
//}
//
//let student2 = SSacStudent(name: "Park")
//print(student2.name)
//


let number = 5

func numberFunction() -> Bool {
    
    if number > 3 {
        
        return true

    } else {

        return false
    }

    guard number > 3 else { return false }
    return true

}

numberFunction()

var myName: String?
myName = "Park"

if let name = myName {
    print(name)
} else {
    print("이름이 없습니다.")
}

func nameFunction() {
    
    guard let name = myName else { return }
    print(name)
    print("myName에 값이 없다면 guard문 이하의 구문은")
    print("실행되지 않음.")
    
}

nameFunction()


