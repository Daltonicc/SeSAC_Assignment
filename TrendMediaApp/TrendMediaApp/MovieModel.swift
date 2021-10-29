//
//  MovieModel.swift
//  TrendMediaApp
//
//  Created by 박근보 on 2021/10/26.
//

import Foundation

struct MovieModel {
    
    var titleData: String
    var imageData: String
    var linkData: String
    var userRatingData: String
    var subtitle: String
    
}

struct trendModel {
    
    var title: String
    var voteAverage: Double
    var overview: String
    var releaseDate: String
    var poster: String
    var genre: [Any]
}

struct genreModel {
    
    var idAndName: [Int : String] = [:]
}
