//
//  Movies.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import Foundation
import SwiftUI

class MovieResults: Identifiable,Decodable {
    let page: Int?
    let numResults: Int?
    let numPages: Int?
    var movies: [MovieInfo]
    
    private enum CodingKeys: String, CodingKey {
        case page, 
             numResults = "total_results",
             numPages = "total_pages", 
             movies = "results"
    }
}


class MovieInfo: Identifiable, Decodable {
    let id: Int
    let posterPath: String?
    let title: String
    let voteAverage: Double?
    let voteCount: Int?
    let releaseDate: String?
    let backdropPath: String?
    let overview: String?
    let originalTitle: String?
    let popularity: Double?
    let genresIDs: [Int]?
    
    private enum CodingKeys: String, CodingKey {
        case id,
             title,
             overview,
             popularity,
             posterPath = "poster_path",
             voteAverage = "vote_average",
             voteCount = "vote_count",
             backdropPath = "backdrop_path",
             releaseDate = "release_date",
             originalTitle = "original_title",
             genresIDs = "genre_ids"
    }
}


class MoviePics: ObservableObject, Decodable{
    var backdrops: [PicData] = []
    var posters: [PicData] = []
    var logos: [PicData] = []
    var finished: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case backdrops = "backdrops",
             posters = "posters",
             logos = "logos"
    }
    
    func getImgs(id: Int, size: String = "w342") {
        if !self.finished{
            var counter = 0
            downloadMoviePics(id: id, completed: { r in
                for i in r.backdrops ?? []{
                    getImage(url: i.file_path ?? "", size: size, completed: { g in
                        self.backdrops.append(PicData(id: i.file_path ?? "", img: g))
                    })
                    counter += 1
                }
            })
        }
    }
}
 

class PicData: Identifiable, Decodable{
    let vote_average: Double?
    let file_path: String?
    let vote_count: Int?
    
    private enum CodingKeys: String, CodingKey {
        case vote_count,
             vote_average = "vote_average",
             file_path = "file_path"
    }
    
    init(id: String, img: PicData) {
        self.file_path = id
        self.vote_count = img.vote_count
        self.vote_average = img.vote_average
    }
}







