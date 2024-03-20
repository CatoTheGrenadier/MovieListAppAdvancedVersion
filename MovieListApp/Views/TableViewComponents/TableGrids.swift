//
//  MasterGrids.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/26/24.
//

import Foundation
import SwiftUI

struct TableGrids:View {
    @State var type:String
    @State var DeletedMovies:DeletedMovieIds
    @State var Genres : GenresMap
    @ObservedObject var lastMovie:LastMovie
    @State var chosenType: String? = "null"
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
        VStack(alignment:.leading){
            let columns = [
                GridItem(.flexible())
            ]
            
            NavigationLink(
                destination: MasterView(Genres:Genres,DeletedMovies:DeletedMovies ,type: type, lastMovie:lastMovie,profileRep: profileRep)
                            .padding()
                ,
                tag:type
                ,
                selection: $chosenType
                ,
                label: {
                    LazyVGrid(columns: columns){
                        Text("\(type_name)")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .font(.largeTitle)
                            .frame(width:300,height:200)
                            .cornerRadius(30)
                            .background(Color.yellow)
                            .cornerRadius(30)
                    }
                }
            )
            .onAppear{
                if lastMovie.showORnot{
                    chosenType = lastMovie.category ?? "default" 
                }
            }
        }
        .padding(.vertical)
    }
}

#Preview {
    TopView()
}
