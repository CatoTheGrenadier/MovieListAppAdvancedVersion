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
    @State var Genres: GenresMap
    @State var dummy_detail = 0
    @State var backDrops: [PicData] = []
    @State var genre: String = ""
    @State var lastMovie:LastMovie
    var body: some View{
        ScrollView{
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
                
                let genreList = singleMovie.genresIDs ?? []
                HStack{
                    Text("Genre: ")
                        .font(.title3)
                        .fontWeight(.heavy)
                    ScrollView(.horizontal){
                        HStack{
                            ForEach(genreList, id: \.self){genreID in
                                Text("\(Genres.storedMap[genreID ] ?? "default")")
                                    .fontWeight(.semibold)
                                    .foregroundColor(Color.red)
                            }
                        }
                    }
                }
                
                HStack{
                    Text("Rating: ")
                        .font(.title3)
                        .fontWeight(.heavy)
                    
                    StarsView(rating: (singleMovie.voteAverage ?? 0.0) / 2, maxRating: 5)
                }
                
                if dummy_detail > 0{
                    ScrollView(.horizontal){
                        HStack(spacing:10){
                            ForEach(backDrops){ backdrop in
                                AsyncImage(url:URL(string: "https://image.tmdb.org/t/p/w500/\(backdrop.file_path ?? "default")")) { image in
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
                
                Text("Description:")
                    .font(.title3)
                    .fontWeight(.heavy)
                
                Text("\n\(singleMovie.overview ?? "default")")
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    TopView()
}

