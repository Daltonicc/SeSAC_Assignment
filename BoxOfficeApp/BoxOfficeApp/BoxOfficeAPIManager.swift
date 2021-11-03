//
//  BoxOfficeAPIManager.swift
//  BoxOfficeApp
//
//  Created by 박근보 on 2021/11/03.
//

import Foundation
import Alamofire
import SwiftyJSON

class BoxAPIManager {
    
    var boxData: [BoxModel] = []
    var date: String = "20211102"
    
    static let shared = BoxAPIManager()

    func getBoxOfficeData(result:@escaping (JSON) -> () ) {
        
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20201101"
                
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["boxOfficeResult"]["dailyBoxOfficeList"].arrayValue {
                    
                    let rank = item["rank"].stringValue
                    let title = item["movieNm"].stringValue
                    let releaseDate = item["openDt"].stringValue
                    
                    let data = BoxModel(rank: rank, title: title, releaseDate: releaseDate)
                    
                    self.boxData.append(data)
                }
                
                result(json)
                print(self.boxData)
                
            case .failure(let error):
                print(error)
            }
        }
    }

}
