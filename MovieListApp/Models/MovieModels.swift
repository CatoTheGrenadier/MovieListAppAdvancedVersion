//
//  Movies.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import Foundation
import SwiftUI
import FirebaseFirestore

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


class MovieInfo: Identifiable, Encodable, Decodable {
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
    
    init(){
        id = 0
        posterPath = "null"
        title = "null"
        voteAverage = 0.0
        voteCount = 0
        releaseDate = "null"
        backdropPath = "null"
        overview = "null"
        originalTitle = "null"
        popularity = 0.0
        genresIDs = []
    }
    
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


class MovieGenres: Identifiable, Decodable {
    var genres: [SingleMovieGenre]
    var finished: Bool = false
    
    private enum CodingKeys: String,CodingKey{
        case genres = "genres"
    }
    
    func getGer() {
        if !self.finished{
            var counter = 0
            downloadMovieGenres(completed: { r in
                for _ in r.genres {
                    getGenre(completed: { g in
                        self.genres.append(SingleMovieGenre(genre:g))
                    })
                    counter += 1
                }
            })
        }
    }
}


class SingleMovieGenre: Identifiable,Decodable {
    var id: Int?
    var name: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id",
             name = "name"
    }
    
    init(genre: SingleMovieGenre) {
        self.id = genre.id
        self.name = genre.name
    }
    
}

class GenresMap: ObservableObject{
    @Published var storedMap: [Int:String] = [:]
    
    init(){
        downloadMovieGenres(){genres in
            for genre in genres.genres{
                self.storedMap[genre.id ?? 0] = genre.name ?? "default"
            }
        }
    }
}

class DeletedMovieIds: ObservableObject,Decodable, Encodable{
    @Published var deletedList: Set<Int>?
    
    enum CodingKeys: String, CodingKey {
            case deletedList
        }
    
    init(){
        loadDeletedMovies(completed: { r in
            self.deletedList = r.deletedList
        })
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        deletedList = try container.decode(Set<Int>.self, forKey: .deletedList)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(deletedList, forKey: .deletedList)
    }
    
    func EncodeAndWriteToFile(){
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let fileURL = Bundle.main.url(forResource: "Deleted", withExtension: "json") {
                    do {
                        try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
                            print("JSON string written to file")
                        } catch {
                            print("Error writing JSON string to file")
                        }
                        print("File successfully grabbed!")
                    
                } else {
                    print("File not found in the bundle.")
                }
            }
        } catch{
            print("Error encoding JSON")
        }
    }
}


class LastMovie: ObservableObject, Identifiable,Encodable, Decodable {
    @Published var movie: MovieInfo?
    @Published var showORnot: Bool = false
    @Published var category: String? = "null"
    
    private enum CodingKeys: String, CodingKey {
        case movie = "movie",
             showORnot = "showORnot",
             category = "category"
    }
    
    init(){
        loadLastMovie(completed: { r in
            self.movie = r.movie
            self.showORnot = r.showORnot
            self.category = r.category
         })
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        movie = try container.decode(MovieInfo.self, forKey: .movie)
        showORnot = try container.decode(Bool.self, forKey: .showORnot)
        category = try container.decode(String.self, forKey: .category)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(movie, forKey: .movie)
        try container.encode(showORnot, forKey: .showORnot)
        try container.encode(category, forKey: .category)
    }
    
    func EncodeAndWriteToFile(){
        do {
            let jsonData = try JSONEncoder().encode(self)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                if let fileURL = Bundle.main.url(forResource: "LastMovie", withExtension: "json") {
                    print(fileURL)
                    do {
                        try jsonString.write(to: fileURL, atomically: true, encoding: .utf8)
                            print("JSON string written to file")
                        } catch {
                            print("Error writing JSON string to file")
                        }
                        print("File successfully grabbed!")
                    
                } else {
                    print("File not found in the bundle.")
                }
            }
        } catch{
            print("Error encoding JSON")
        }
    }
}

class Profile: ObservableObject, Identifiable, Codable {
    @DocumentID var id : String?
    var username = "username"
    var gender = "gender"
    var mood = "mood"
    var picUrl = ""
    var favouriteList : [Int]
    
    init(){
        self.favouriteList = []
    }
}

extension Profile {
    static let documentName = "profile"
}



