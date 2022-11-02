//
//  DetailView.swift
//  MoveeApp
//
//  Created by admin on 29.10.2022.
//

import SwiftUI
import Kingfisher

struct DetailView: View {
    @ObservedObject private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                CustomImageView(path: viewModel.title.backdropPath, imageRes: .highRes)
                
                Text(viewModel.getTitleName())
                    .font(.system(.largeTitle))
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
            } .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
        } .navigationTitle(viewModel.getTitleName())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(viewModel: DetailViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
