//
//  SingleMovieDetail.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/25/24.
//

import Foundation
import SwiftUI

struct SingleMovieDetail: View{
    @State var singleMovie: MovieInfo
    @State var dummy_detail = 0
    @State var backDrops: [PicData] = []
    var body: some View{
        VStack(alignment:.leading){
            Text("\(singleMovie.title)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.vertical)
                .onAppear(){
                    downloadMoviePics(id: singleMovie.id){ results in
                        backDrops = results.backdrops
                        dummy_detail += 1
                    }
                }
            
            Text("Release Date:")
                .font(.title3)
                .fontWeight(.heavy)
            +
            Text("  \(singleMovie.releaseDate ?? "default")")
            
            
            if dummy_detail > 0{
                ScrollView(.horizontal){
                    HStack(spacing:10){
                        ForEach(backDrops){ backdrop in
                            AsyncImage(url:URL(string: "https://image.tmdb.org/t/p/w92/\(backdrop.file_path ?? "default")")) { image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:350, height:300)
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }
            
            Text("Overview:")
                .font(.title3)
                .fontWeight(.heavy)
            
            Text("\n\(singleMovie.overview ?? "default")")
        }
        .padding()
        Spacer()
    }
}

#Preview {
    TableView()
}

