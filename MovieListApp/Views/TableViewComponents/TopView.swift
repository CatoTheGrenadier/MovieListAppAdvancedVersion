//
//  ContentView.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import SwiftUI

struct TopView: View {
    var body: some View {
        NavigationView{
            List{
                ScrollView{
                    TableGrids(type: "popular")
                    TableGrids(type: "top_rated")
                    TableGrids(type: "upcoming")
                    TableGrids(type: "now_playing")
                }
                .padding(0)
            }
        }
    }
    
}

#Preview {
    TopView()
}
