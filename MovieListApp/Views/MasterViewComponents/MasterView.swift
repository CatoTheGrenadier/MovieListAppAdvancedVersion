//
//  MasterView.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import Foundation
import SwiftUI

struct MasterView: View {
    @State private var movieResults: MovieResults?
    @State var Genres: GenresMap
    @ObservedObject var DeletedMovies: DeletedMovieIds
    @State private var dummy_name = 0
    @State private var isBackButtonHidden = false
    @State var type : String
    @ObservedObject var lastMovie : LastMovie
    @State var isTypeActive: Bool = false
    @State var jumpId: Int? = -1
    @ObservedObject var profileRep: ProfileRepository
    
    var type_name: String {
        if type == "popular" {
            return "Popular"
        } else if type == "top_rated" {
            return "Top Rated"
        } else if type == "now_playing" {
                return "Now Playing"
        } else if type == "upcoming" {
                return "Upcoming"
        } else {
            return "Unknown"
        }
    }
    
    var body: some View {
        if !isBackButtonHidden{
            Text("\(type_name)")
                .fontWeight(.bold)
                .padding(0)
                .font(.largeTitle)
                .onAppear {
                    downloadMovieList(type: type) { results in
                        movieResults = results
                        dummy_name += 1
                    }}
        }
        NavigationView{
            List{
                if dummy_name != 0 {
                    ForEach(movieResults?.movies ?? []) { singleMovie in
                        if !(DeletedMovies.deletedList ?? []).contains(singleMovie.id){
                            HStack{
                                NavigationLink(
                                    destination: SingleMovieDetail(singleMovie:singleMovie,Genres:Genres, lastMovie:lastMovie, profileRep: profileRep)
                                    
                                        .onAppear {
                                            isBackButtonHidden.toggle()
                                            lastMovie.movie = singleMovie
                                            lastMovie.showORnot = true
                                            lastMovie.category = type
                                            lastMovie.EncodeAndWriteToFile()
                                        }
                                        .onDisappear {
                                            lastMovie.showORnot = false
                                            lastMovie.EncodeAndWriteToFile()
                                            isBackButtonHidden.toggle()
                                        }
                                    ,
                                    tag:singleMovie.id
                                    ,
                                    selection: $jumpId
                                    ,
                                    label: {
                                        SingleMovieRow(singleMovie: singleMovie, profileRep: profileRep)
                                            .swipeActions {
                                                if profileRep.profile.favouriteList.contains(singleMovie.id) {
                                                    Button("♡ Unfavourite") {
                                                        DispatchQueue.main.async{
                                                            profileRep.unfavouriteMovie(movieId: singleMovie.id)
                                                        }
                                                    }
                                                    .tint(.gray)
                                                } else {
                                                    Button("♥ Favourite") {
                                                        DispatchQueue.main.async{
                                                            profileRep.favouriteMovie(movieId: singleMovie.id)
                                                        }
                                                    }
                                                    .tint(.green)
                                                }
                                                
                                                Button("Delete") {
                                                    DeletedMovies.deletedList?.insert(singleMovie.id)
                                                    DeletedMovies.EncodeAndWriteToFile()
                                                }
                                                .tint(.red)
                                            }
                                    }
                                )
                                .padding(.horizontal,15)
                            }
                        }
                    }
                }
            }
        }
        .padding(0)
        .navigationBarBackButtonHidden(isBackButtonHidden)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear{
            if lastMovie.showORnot == true {
                jumpId = (lastMovie.movie ?? MovieInfo()).id
            }
        }
    }
}

#Preview {
    TopView()
}
