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
                                                DeletedMovies.deletedList?.insert(singleMovie.id)
                                                DeletedMovies.EncodeAndWriteToFile()
                                                print(DeletedMovies.deletedList)
                                            }label: {
                                                Text("Delete Movie")
                                                    .padding()
                                            }
                                            .tint(.red)
                                        }
                                }
                            )
                        }
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
