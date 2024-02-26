//
//  MasterGrids.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/26/24.
//

import Foundation
import SwiftUI

struct TableGrids:View {
    @State var Genres = GenresMap()
    @State var DeletedMovies = DeletedMovieIds()
    @State var type:String
    
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
            
            Text("\(type_name)")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding(.trailing,40)
                .swipeActions {
                        Button("Burn") {
                            print("Right on!")
                        }
                            .tint(.red)
                    }
            
            NavigationLink(
                destination: MasterView(Genres:Genres,DeletedMovies:DeletedMovies ,type: type)
                            .padding()
                ,
                label: {
                    LazyVGrid(columns: columns){
                        Rectangle()
                            .frame(width:300,height:200)
                            .cornerRadius(30)
                    }
                }
            )
        }
        .padding(.vertical)
    }
}

#Preview {
    TopView()
}
