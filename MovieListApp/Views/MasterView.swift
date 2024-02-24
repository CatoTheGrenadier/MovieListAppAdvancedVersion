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
    @State private var dummy = false
    var body: some View {
        VStack {
            Text("Popular Movies")
                    .onAppear {
                        downloadMovieList(type: "popular") { results in
                            movieResults = results
                            for k in movieResults!.movies{
                                print(k.originalTitle ?? "default")
                            }
                            dummy.toggle()
                        }
                    }
            if dummy{
                VStack(spacing:0){
                    ForEach(movieResults!.movies) { singleMovie in
                        HStack{
                            Text("\(singleMovie.title)")
                                .padding()
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    TableView()
}
