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
    var body: some View {
        VStack(alignment:.leading) {
            Text("Popular Movies")
                .fontWeight(.bold)
                .padding(.vertical,50)
                .font(.largeTitle)
                .onAppear {
                    downloadMovieList(type: "popular") { results in
                        movieResults = results
                        for k in movieResults!.movies{
                            print(k.originalTitle ?? "default")
                        }
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
                    }
                }
            }
        }
    }
}

#Preview {
    TableView()
}
