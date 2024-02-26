//
//  DetailViewBackButton.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/26/24.
//

import Foundation
import SwiftUI

struct DetailViewBackButton:View {
    @Environment(\.dismiss) var dismiss
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
        Button(action:{
            dismiss()
        }){
            HStack{
                Text("<")
                    .font(.title3)
                    .fontWeight(.bold)
                Text("\(type_name) Movies")
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding(0)
        }
    }
}

#Preview {
    TopView()
}
