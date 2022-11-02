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
        HStack(alignment: .center, spacing: 10) {
            CustomImageView(path: viewModel.title.posterPath, imageRes: .lowRes)
            
            VStack(alignment: .leading, spacing: 25) {
                Text(viewModel.getTitleName())
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .lineLimit(1)
                Text(viewModel.getGenreString())
                HStack {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                        Text(viewModel.getNewDateStyle())
                    }
                    Divider().fixedSize()
                    HStack {
                        Image(systemName: "star.fill")
                        Text(viewModel.getVoteAverage())
                    }
                    .padding(.horizontal, 10.0)
                    .padding(.vertical, 5.0)
                    .foregroundColor(Color.white)
                    .background(.blue)
                    .cornerRadius(/*@START_MENU_TOKEN@*/20.0/*@END_MENU_TOKEN@*/)
                }
            }
        } .contentShape(Rectangle())
    }
}


struct ListCellView_Previews: PreviewProvider {
    static var previews: some View {
        ListCellView(viewModel: ListCellViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
