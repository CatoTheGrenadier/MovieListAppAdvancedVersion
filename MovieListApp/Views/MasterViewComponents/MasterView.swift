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
    @State var DeletedMovies: DeletedMovieIds
    @State private var dummy_name = 0
    @State private var isBackButtonHidden = false
    @State private var updateState = false
    @State private var inChildView = false
    @State var type : String
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
                        print(dummy_name)
                        updateState.toggle()
                    }}
        }
        NavigationView{
            List{
                if dummy_name != 0 {
                        ForEach(movieResults?.movies ?? []) { singleMovie in
                                NavigationLink(
                                    destination: SingleMovieDetail(singleMovie:singleMovie,Genres:Genres)
                                        .navigationBarBackButtonHidden(true)
                                        .navigationBarItems(leading: DetailViewBackButton(type:type))
                                        .onAppear {
                                            isBackButtonHidden.toggle()
                                        }
                                        .onDisappear {
                                            isBackButtonHidden.toggle()
                                        }
                                    ,
                                    label: {
                                        SingleMovieRow(singleMovie: singleMovie)
                                            .swipeActions {
                                                    Button {
                                                        DeletedMovies.deletedList.insert(singleMovie.id)
                                                        print("I just swiped")
                                                        print(DeletedMovies.deletedList)
                                                    }label: {
                                                        Text("Hello swipe")
                                                    }
                                            }
                                     }
                                )
                            }
                        
                    
                }
            }
        }
        .padding(0)
        .navigationBarBackButtonHidden(isBackButtonHidden)
    }
}

#Preview {
    TopView()
}
