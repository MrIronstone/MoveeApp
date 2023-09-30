//
//  StarRatingView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 19.09.2023.
//

import SwiftUI

struct StarRatingView: View {
    @State var rating: Int
    var viewModel: DetailViewModel
        
    var body: some View {
        HStack {
            ForEach(1...5, id: \.self) { number in
                showStar(for: number)
                    .foregroundColor(Color.blue)
                    .onTapGesture {
                        rating = number
                        viewModel.addRating(rating: rating)
                    }
                    .onLongPressGesture {
                        rating = 0
                        viewModel.removeRating()
                    }
            }
            .font(.largeTitle)
        }
    }
    
    func showStar(for number: Int) -> Image {
        number > rating ? Image(systemName: "star") : Image(systemName: "star.fill")
    }
}

struct StarRatingView_Previews: PreviewProvider {
    static var previews: some View {
        StarRatingView(rating: 0, viewModel: DetailViewModel(title: .example1(), genreList: .example1()))
    }
}
