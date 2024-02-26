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
    @State private var dummy_name = 0
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
        VStack(alignment:.leading) {
            Text("\(type_name)")
                .fontWeight(.bold)
                .padding(.bottom,50)
                .font(.largeTitle)
                .onAppear {
                    downloadMovieList(type: type) { results in
                        movieResults = results
                        dummy_name += 1
                    }
                }
            if !(dummy_name == 0) {
                VStack(alignment: .leading) {
                    ForEach(movieResults?.movies ?? []) { singleMovie in
                        NavigationLink(
                            destination: SingleMovieDetail(singleMovie:singleMovie),
                            label: {
                                SingleMovieRow(singleMovie: singleMovie)
                            }
                        )
                        Divider()
                            .background(Color.black)
                            .padding(.horizontal,0)
                    }
                }
            }
        }
    }
}

#Preview {
    TableView()
}
