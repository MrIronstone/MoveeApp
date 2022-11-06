//
//  ButtonAndResultView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import SwiftUI

struct ListView: View {
    @ObservedObject private var viewModel = ListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(viewModel.nowPlayingMovies) { row in
                            NavigationLink {
                                DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.movieGenres))
                            } label: {
                                CardCellView(viewModel: CardCellViewModel(title: row, genreList: viewModel.movieGenres))
                            }
                        }
                    }
                } .navigationTitle("Now Playing Movies")
    
                ForEach(viewModel.populerMovies) { row in
                    NavigationLink {
                        DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.movieGenres))
                    } label: {
                        ListCellView(viewModel: ListCellViewModel(title: row, genreList: viewModel.movieGenres))
                            .frame(height: 120)
                    }
                }
            } .navigationTitle("Popular Movies")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
