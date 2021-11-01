//
//  MainAPIManager.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/11/01.
//

import Foundation
import Alamofire
import SwiftyJSON


class MainAPIManager {
    
    var genreData: [Int : String] = [:]
    var trendData: [TrendModel] = []
    var startPage = 1
    
    static let shared = MainAPIManager()
    
    func getGenreData() {
        
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=0ddf09d4942a5788f4b0857f6895c28c&language=en-US"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                //장르 딕셔너리에 담아주기
                for item in json["genres"].arrayValue {
                    
                    let genreid = item["id"].intValue
                    let genrename = item["name"].stringValue
                    
                    self.genreData.updateValue(genrename, forKey: genreid)
                    
                }
                print(self.genreData)
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    func getMovieData(result:@escaping (JSON) -> ()) {
        
        let url = "https://api.themoviedb.org/3/trending/movie/day?api_key=0ddf09d4942a5788f4b0857f6895c28c&page=\(startPage)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                for item in json["results"].arrayValue {
                    
                    let title = item["title"].stringValue
                    let voteAverage = item["vote_average"].doubleValue
                    let overview = item["overview"].stringValue
                    
                    let backdropImage = item["backdrop_path"].stringValue
                    let backdropUrl = "https://image.tmdb.org/t/p/original/\(backdropImage)"
                    
                    let poster = item["poster_path"].stringValue
                    let posterUrl = "https://image.tmdb.org/t/p/original/\(poster)"
                    
                    
                    let releaseDate = item["release_date"].stringValue
                    let movieid = item["id"].intValue
                    
                    var genreList: [Any] = []

                    for i in 0..<item["genre_ids"].count {
                        
                        if let genre = self.genreData[item["genre_ids"][i].intValue] {
                            
                            genreList.append(genre)
                        }
                        
                    }
                    
                    let data = TrendModel(title: title, voteAverage: voteAverage, overview: overview, releaseDate: releaseDate, poster: posterUrl, backdropImage: backdropUrl ,genre: genreList, moiveid: movieid)
                    
                    self.trendData.append(data)
                    
                }
                
                result(json)
                
//                self.MovieTableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
