//
//  ListCellView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 27.10.2022.
//

import SwiftUI
import Kingfisher

struct ListCellView: View {
    @ObservedObject private var viewModel: ListCellViewModel
    
    init(viewModel: ListCellViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack(spacing: 10) {
            CustomImageView(path: viewModel.title.posterPath, imageRes: .lowRes)
                .frame(height: 150)
            VStack(alignment: .leading, spacing: 25) {
                Text(viewModel.title.getTitleName())
                    .font(.system(size: 24))
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text(viewModel.title.getGenreString(with: viewModel.genreList))
                    .font(.system(size: 18))
                    .lineLimit(1)
                HStack {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        Text(viewModel.title.getNewDateStyle())
                            .font(.system(size: 14))
                    }
                    Divider().fixedSize()
                    HStack {
                        Image(systemName: "star.fill")
                        Text(viewModel.title.getVoteAverage())
                            .font(.system(size: 12))
                    }
                    .padding(.horizontal, 10.0)
                    .padding(.vertical, 5.0)
                    .foregroundColor(Color.white)
                    .background(.blue)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
            } .frame(maxWidth: .infinity)
            Spacer()
        }   .background(.ultraThinMaterial)
            .shadow(color: .black, radius: 360, x: 0, y: 5)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}


struct ListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ListCellView(viewModel: ListCellViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
