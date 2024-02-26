//
//  singleMovieRow.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/25/24.
//

import Foundation
import SwiftUI

struct SingleMovieRow: View{
    @State var singleMovie: MovieInfo
    @State private var dummy_image = 0
    @State private var path = ""
    var body: some View{
        HStack{
             if dummy_image != 0{
                 AsyncImage(url:URL(string: "https://image.tmdb.org/t/p/w92/\(path)")) { image in
                     image
                         .resizable()
                         .scaledToFit()
                 } placeholder: {
                     ProgressView()
                 }
                 .frame(alignment:.leading)
                 .frame(width:150)
                 .padding(.horizontal,15)
             }
            
            Text("\(singleMovie.title)")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .onAppear(){
                    downloadMoviePics(id: singleMovie.id){ results in
                        let backdrops = results.backdrops
                        for backdrop in backdrops{
                            path = backdrop.file_path ?? "default"
                        }
                        dummy_image += 1
                    }
                }
        }
        .frame(alignment:.leading)
    }
}

#Preview {
    TableView()
}
