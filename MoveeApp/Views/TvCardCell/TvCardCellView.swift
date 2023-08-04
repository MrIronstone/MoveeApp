//
//  TvCardCellView.swift
//  MoveeApp
//
//  Created by admin on 27.12.2022.
//

import SwiftUI

struct TvCardCellView: View {
    @ObservedObject private var viewModel: CardCellViewModel
    
    init(viewModel: CardCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomImageView(path: viewModel.title.posterPath, imageRes: .lowRes)
                .frame(height: 250)
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text(viewModel.title.getTitleName())
                        .font(.system(size: 16))
                        .fontWeight(.bold)
                        .lineLimit(1)
                }
                .foregroundColor(.black)
                HStack {
                    Image(systemName: "star.fill")
                    Text(viewModel.title.getVoteAverage())
                }   .padding(.horizontal, 10.0)
                    .padding(.vertical, 5.0)
                    .foregroundColor(Color.white)
                    .background(.blue)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
            }
        }
        .frame(width: 170)
        .background(.regularMaterial)
            .cornerRadius(10)
            .overlay {
            RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.4), lineWidth: 1.5)
            }
    }
}

/*
struct CardCellView_Previews: PreviewProvider {
    static var previews: some View {
        CardCellView(viewModel: CardCellViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
*/

struct TvCardCellView_Previews: PreviewProvider {
    static var previews: some View {
        TvCardCellView(viewModel: CardCellViewModel.init(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
