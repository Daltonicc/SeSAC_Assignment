import UIKit


class SeSacStudent {
    
    var name: String
    
    init(realname: String) {
        self.name = realname
    }
    
}

let student1 = SeSacStudent(realname: "Park")
print(student1.name)


struct SSacStudent {
    
    var name: String
}

let student2 = SSacStudent(name: "Park")
print(student2.name)
