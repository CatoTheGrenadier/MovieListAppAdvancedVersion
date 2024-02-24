//
//  ContentView.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import SwiftUI

struct TableView: View {
    @State private var movieResults: MovieResults?
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button("Download Movies") {
                downloadMovieList(type: "popular") { results in
                    // Handle the downloaded movie results
                    movieResults = results
                    for singleMovie in movieResults!.movies{
                        print(singleMovie.overview ?? "default")
                    }
                }
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    TableView()
}
