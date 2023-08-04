//
//  CardCellView.swift
//  MoveeApp
//
//  Created by admin on 7.11.2022.
//

import SwiftUI

struct CardCellView: View {
    @ObservedObject private var viewModel: CardCellViewModel
    
    init(viewModel: CardCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            CustomImageView(path: viewModel.title.posterPath, imageRes: .lowRes)
                .frame(height: 400)
                .padding(EdgeInsets(top: 0, leading: 50, bottom: 0, trailing: 0))
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "star.fill")
                    Text(viewModel.title.getVoteAverage())
                }   .padding(.horizontal, 10.0)
                    .padding(.vertical, 5.0)
                    .foregroundColor(Color.white)
                    .background(.blue)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                VStack(alignment: .leading) {
                    Text(viewModel.title.getTitleName())
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .lineLimit(1)
                    Text(viewModel.title.getGenreString(with: viewModel.genreList))
                        .font(.system(size: 15))
                        .lineLimit(1)
                }
                .foregroundColor(Color.black)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 0))
        }
        .frame(width: 320, height: 530, alignment: .leading)
    }
}

struct CardCellView_Previews: PreviewProvider {
    static var previews: some View {
        CardCellView(viewModel: CardCellViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
