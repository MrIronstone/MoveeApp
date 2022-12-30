//
//  TvSeriesView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 24.11.2022.
//

import SwiftUI

struct TvSeriesView: View {
    @ObservedObject private var viewModel = TvSeriesViewModel()
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    VStack {
                        Text("TV Series")
                            .font(.system(size: 41).bold())
                            .padding(EdgeInsets(top: 150, leading: -150, bottom: 0, trailing: 0))
                            .foregroundColor(Color.white)
                            .frame(width: 400, height: 300, alignment: .top)
                            .background(Color.blue)
                            .padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
                        
                        ScrollView(.horizontal) {
                            LazyHStack(spacing: 10) {
                                ForEach(viewModel.populerTvSeries) { row in
                                    NavigationLink {
                                        DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.tvGenres))
                                    } label: {
                                        CardCellView(viewModel: CardCellViewModel(title: row, genreList: viewModel.tvGenres))
                                    }
                                }
                            }
                        } .padding(EdgeInsets(top: -70, leading: 0, bottom: 0, trailing: 0))
                    }
                    Divider()
                    LazyVStack(alignment: .leading) {
                        Text("Top Rated")
                            .font(.system(size: 22).bold())
                        LazyVGrid(columns: columns) {
                            ForEach(viewModel.topRatedTvSeries) { row in
                                NavigationLink {
                                    DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.tvGenres))
                                } label: {
                                    TvCardCellView(viewModel: CardCellViewModel(title: row, genreList: viewModel.tvGenres))
                                }
                            }
                        }
                    }
                    .foregroundColor(Color.black)
                    .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                }
            }
        }
    }
}

struct TvSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        TvSeriesView()
    }
}
