//
//  MovieData.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import Foundation
import SwiftUI

let apiKey = 

func downloadMovieList(type: String, completed: @escaping (MovieResults) -> () ) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(type)?api_key=" + apiKey)
    URLSession.shared.dataTask(with: url!){ (data, response, err) in
        if err == nil {
            guard let jsondata = data else { return }
            do {
                let results = try JSONDecoder().decode(MovieResults.self, from: jsondata)
                print("JSON download sucessful!")
                DispatchQueue.main.async {
                    completed(results)
                }
            }catch {
                print("JSON Downloading Error!")
            }
        }
    }.resume()
}

func downloadMoviePics(id: Int, completed: @escaping (MoviePics) -> () ) {
    let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/images?api_key=" + apiKey)
    URLSession.shared.dataTask(with: url!){ (data, response, err) in
        if err == nil {
            guard let jsondata = data else { return }
            do {
                let results = try JSONDecoder().decode(MoviePics.self, from: jsondata)
                DispatchQueue.main.async {
                    completed(results)
                }
            }catch{
                print("JSON Downloading Error!")
            }
        }
    }.resume()
}


func getImage(url: String?, size: String, completed: @escaping (PicData) -> ()) {
    let url = URL(string: "http://image.tmdb.org/t/p/\(size)/\(url ?? "default")?api_key=" + apiKey)
    URLSession.shared.dataTask(with: url!){ (data, response, err) in
        if err == nil {
            guard let jsondata = data else { return }
            do {
                let results = try JSONDecoder().decode(PicData.self, from: jsondata)
                DispatchQueue.main.async {
                    completed(results)
                }
            }catch{
                print("JSON Downloading Error!")
            }
        }
    }.resume()
}


func downloadMovieGenres(completed: @escaping (MovieGenres) -> ()) {
    let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=" + apiKey)
    URLSession.shared.dataTask(with: url!){ (data, response, err) in
        if err == nil {
            guard let jsondata = data else { return }
            do {
                let results = try JSONDecoder().decode(MovieGenres.self, from: jsondata)
                DispatchQueue.main.async {
                    completed(results)
                }
            }catch{
                print("JSON Downloading Error!")
            }
        }
    }.resume()
}


func getGenre(completed: @escaping (SingleMovieGenre) -> ()) {
    let url = URL(string: "https://api.themoviedb.org/3/genre/movie/list?api_key=" + apiKey)
    URLSession.shared.dataTask(with: url!){ (data, response, err) in
        if err == nil {
            guard let jsondata = data else { return }
            do {
                let results = try JSONDecoder().decode(SingleMovieGenre.self, from: jsondata)
                DispatchQueue.main.async {
                    completed(results)
                }
            }catch{
                print("JSON Downloading Error!")
            }
        }
    }.resume()
}

func loadDeletedMovies(completed: @escaping (DeletedMovieIds) -> ()){
    if let fileURL = Bundle.main.url(forResource: "Deleted", withExtension: "json") {
        do {
            let data = try Data(contentsOf: fileURL)
            let results = try JSONDecoder().decode(DeletedMovieIds.self, from: data)
            DispatchQueue.main.async {
                completed(results)
            }
            print("File successfully read!")
        }
        catch{
            print("Error loading deleted movies file!")
        }
        
    } else {
        print("File not found in the bundle.")
    }
}

func loadLastMovie(completed: @escaping (LastMovie) -> ()){
    if let fileURL = Bundle.main.url(forResource: "LastMovie", withExtension: "json") {
        do {
            let data = try Data(contentsOf: fileURL)
            let results = try JSONDecoder().decode(LastMovie.self, from: data)
            DispatchQueue.main.async {
                completed(results)
            }
            print("File successfully read!")
        }
        catch{
            print("Error loading lastmovie file!")
        }
        
    } else {
        print("File not found in the bundle.")
    }
}


