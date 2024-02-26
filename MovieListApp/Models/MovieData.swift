//
//  MovieData.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import Foundation
import SwiftUI

let apiKey = "5763f56108dc124de419d28d03df1748"

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
    print("https://api.themoviedb.org/3/movie/\(id)/images?api_key=" + apiKey)
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
    print("http://image.tmdb.org/t/p/\(size)/\(url ?? "default")?api_key=" + apiKey)
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



