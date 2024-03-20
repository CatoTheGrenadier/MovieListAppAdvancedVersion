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
    @State private var updateState = false
    @ObservedObject var profileRep: ProfileRepository
    
    var body: some View{
        HStack{
            HStack{
                if dummy_image != 0{
                    AsyncImage(url:URL(string: "https://image.tmdb.org/t/p/w500/\(path)")) { image in
                        image
                            .resizable()
                            .frame(width:50,height: 35)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(alignment:.leading)
                    .onAppear{
                        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {_ in
                            updateState.toggle()
                        }
                    }
                }
                Text("\(singleMovie.title)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .padding(.horizontal,15)
                    .onAppear(){
                        downloadMoviePics(id: singleMovie.id){ results in
                            let posters = results.posters
                            for poster in posters{
                                path = poster.file_path ?? "default"
                                break
                            }
                            dummy_image += 1
                        }
                    }
            }
            .frame(alignment:.leading)
            
            Spacer()
            
            if profileRep.profile.favouriteList.contains(singleMovie.id) {
                Button("♥") {}
                .tint(.green)
                .frame(alignment: .trailing)
            } else {
                Button("♡") {}
                .tint(.gray)
                .frame(alignment: .trailing)
            }
        }
    }
}

#Preview {
    TopView()
}
