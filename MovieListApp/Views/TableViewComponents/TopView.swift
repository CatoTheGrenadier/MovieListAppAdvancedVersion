//
//  ContentView.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import SwiftUI

struct TopView: View {
    @State var Genres = GenresMap()
    @State var DeletedMovies = DeletedMovieIds()
    @ObservedObject var lastMovie = LastMovie()
    @State var updateView = false
    
    var body: some View {
        NavigationView{
            List{
                ScrollView{
                    if lastMovie.category != "null" {
                        TableGrids(type: "popular", DeletedMovies: DeletedMovies,Genres: Genres, lastMovie:lastMovie)
                        TableGrids(type: "top_rated", DeletedMovies: DeletedMovies, Genres: Genres, lastMovie:lastMovie)
                        TableGrids(type: "upcoming", DeletedMovies: DeletedMovies, Genres: Genres, lastMovie:lastMovie)
                        TableGrids(type: "now_playing", DeletedMovies: DeletedMovies, Genres: Genres, lastMovie:lastMovie)
                    }
                }
                .padding(0)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
}

#Preview {
    TopView()
}
