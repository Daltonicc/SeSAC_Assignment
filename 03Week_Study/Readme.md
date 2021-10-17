# 03Week_Study

## 관련 개념
* [Optional, Optional Binding, Optional Chaining](https://daltonic.tistory.com/14)
* [Type Casting](https://daltonic.tistory.com/15?category=977963)


## TableViewController Assignment(10/12)

* Case 1(Static Cells)

![Simulator Screen Shot - iPhone 11 - 2021-10-13 at 16 53 53](https://user-images.githubusercontent.com/87598209/137097465-affb130a-6674-42c1-85e3-2895a4c6bab2.png)



* Case 2(Dynamic Prototypes)

![Simulator Screen Shot - iPhone 11 - 2021-10-13 at 16 52 31](https://user-images.githubusercontent.com/87598209/137097438-790401d3-e3c1-4887-bdb6-411011b92537.png)



## 보완 및 생각해봐야할 점
Case 1
* 어트리뷰트 인스펙터만을 활용해서 Header와 Footer의 색상 설정을 못하겠다. 불가능한건지 내가 못찾은건지 확인 필요.


Case 2
* 테이블뷰 스타일 관련 코드?

![스크린샷 2021-10-13 오후 5 06 37(2)](https://user-images.githubusercontent.com/87598209/137098036-e6f52cd3-1e13-4394-b2cd-92d878cc0b12.png)

스타일을 위 코드처럼 설정해보려 했으나 style은 get-only property라며 실패.
tableview = UITableView(frame: .zero, style: .insectGrouped)도 시도해봤으나 스타일은 정상적으로 변했지만 시뮬레이터 돌려보니 일부 UI관련 코드가 작동안함.(배경색, 폰트사이즈 등)

## ExchangeRate Assignment(10/13)

![스크린샷 2021-10-13 오후 4 15 42(2)](https://user-images.githubusercontent.com/87598209/137104010-9e010c54-5408-48d1-8f22-c4d36c715961.png)


## 보완 및 생각해봐야할 점
* 명확히 이해하지 못하고 그냥 쓴 느낌이 강하다. 연산프로퍼티에 관한 정리 필요.

##
### [ShoppingListApp(10/13)](https://github.com/Daltonicc/SeSAC_Assignment/tree/main/ShoppingListApp)
### [TrendMediaApp(10/15)](https://github.com/Daltonicc/SeSAC_Assignment/tree/main/TrendMediaApp)
