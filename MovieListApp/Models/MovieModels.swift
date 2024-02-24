//
//  Movies.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import Foundation

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
    // How is JSON going to be parsed
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




