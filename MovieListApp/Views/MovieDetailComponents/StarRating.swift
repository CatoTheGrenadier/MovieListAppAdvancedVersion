//
//  StarRating.swift
//  MovieListApp
//
//  Created by Yi Ling on 2/26/24.
//

import Foundation
import SwiftUI

struct StarsView: View {
    var rating: Double
    var maxRating: Int

    var body: some View {
        let stars = HStack(spacing: 0) {
            ForEach(0..<maxRating, id: \.self) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.horizontal,5)
            }
        }

        stars.overlay(
            GeometryReader { g in
                let width = rating / Double(maxRating) * g.size.width
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: width)
                        .foregroundColor(.yellow)
                }
            }
            .mask(stars)
        )
        .foregroundColor(.gray)
    }
}

#Preview {
    TopView()
}
