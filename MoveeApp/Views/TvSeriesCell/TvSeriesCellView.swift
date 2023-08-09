//
//  TvSeriesCell.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.11.2022.
//

import SwiftUI

struct TvSeriesCell: View {
    @ObservedObject private var viewModel: TvSeriesCellViewModel
    
    init(viewModel: TvSeriesCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        GeometryReader(content: { _ in
            VStack(alignment: .leading, spacing: 10) {
                CustomImageView(path: viewModel.title.posterPath ?? "", imageRes: .lowRes)
                    .frame(maxWidth: .infinity)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(viewModel.title.getTitleName())
                            .font(.system(size: 28))
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                            .lineLimit(1)
                        HStack {
                            Image(systemName: "star.fill")
                            Text(viewModel.title.getVoteAverage())
                        }   .padding(.horizontal, 10.0)
                            .padding(.vertical, 5.0)
                            .foregroundColor(Color.white)
                            .background(.blue)
                            .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundColor(Color.black)
                }
            }
        })
        .background(.regularMaterial)
        .cornerRadius(10)
    }
}

struct TvSeriesCell_Previews: PreviewProvider {
    static var previews: some View {
        TvSeriesCell(viewModel: TvSeriesCellViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
