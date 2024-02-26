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
    
    var body: some View {
        NavigationView{
            List{
                ScrollView{
                    TableGrids(type: "popular", DeletedMovies: DeletedMovies,Genres: Genres)
                    TableGrids(type: "top_rated", DeletedMovies: DeletedMovies, Genres: Genres)
                    TableGrids(type: "upcoming", DeletedMovies: DeletedMovies, Genres: Genres)
                    TableGrids(type: "now_playing", DeletedMovies: DeletedMovies, Genres: Genres)
                }
                .padding(0)
            }
        }
    }
    
}

#Preview {
    TopView()
}
