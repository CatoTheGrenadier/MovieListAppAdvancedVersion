//
//  ContentView.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/24/24.
//

import SwiftUI

struct TableView: View {
    var body: some View {
        VStack {
            NavigationView{
                ScrollView{
                    MasterView()
                }
            }
        }
    }
}

#Preview {
    TableView()
}
