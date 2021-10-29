import UIKit

//고차함수


//고차함수: 1급 객체 / 매개변수와 반환값에 넣어 줄 수 있는 함수 -> map, filter, reduce

//학생 4.0 이상
let student = [2.2, 5.0, 4.3, 3.3, 2.8, 1.5]
var resultStudent: [Double] = []


for i in student {
    
    if i >= 4.0 {
        resultStudent.append(i)
    }
}

print(resultStudent)

//Filter

let resultFilter = student.filter { value in
                    value >= 4.0
                }
print(resultFilter)

//축약(전달?) 인자인 $0으로 체크. 4.0보다 같거나 큰가?
let result = student.filter{ $0 >= 4.0 }
print(result)

//원하는 영화 - 딕셔너리 형태로
let movieList = [
    "괴물": "박찬욱",
    "기생충": "봉준호",
    "인터스텔라": "크리스토퍼 놀란",
    "다리미": "안녕",
    "인셉션": "크리스토퍼 놀란",
    "옥자": "봉준호"
]

let resultSort = movieList.sorted(by: { $0.key < $1.key })
print(resultSort)

//for (movieName, director) in movieList {
//
//    if director == "봉준호" {
//
//    }
//}

let movieResult = movieList.filter { $0.value == "봉준호"}.map{ $0.key }
print(movieResult)

//map
let number = [1,2,3,4,5,6,7,8,9]

var resultNumber: [Int] = []

for i in number {
    
    let value = i * 2
    resultNumber.append(value)
}

//축약 표현
let resultMap = number.map{ $0 * 2 }
print(resultMap)

//reduce
let exam = [20, 40, 100, 90, 10, 70]
var totalCount = 0

for i in exam {
    totalCount += i
}

let resultTotalCount = exam.reduce(0) { $0 + $1 }
print(resultTotalCount)


