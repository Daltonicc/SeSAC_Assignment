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

struct TrendModel {
    
    var title: String
    var voteAverage: Double
    var overview: String
    var releaseDate: String
    var poster: String
    var backdropImage: String
    var genre: [Any]
    var moiveid: Int
}

struct GenreModel {
    
    var idAndName: [Int : String] = [:]
}

struct CastModel {
    
    var name: String
    var character: String
    var image : String
}
