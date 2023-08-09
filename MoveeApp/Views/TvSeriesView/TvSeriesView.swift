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
        GeometryReader { geometryReader in
            NavigationStack {
                ScrollView {
                    VStack {
                        VStack {
                            Rectangle()
                                .fill(.blue)
                                .frame(
                                    width: geometryReader.size.width,
                                    height: geometryReader.size.height,
                                    alignment: .top
                                )
                                .background(Color.blue)
                                .padding(EdgeInsets(top: -(geometryReader.size.height - 200), leading: 0, bottom: 0, trailing: 0))
                            Text("TV Series")
                                .font(.system(size: 41).bold())
                                .padding(EdgeInsets(top: -150, leading: -150, bottom: 0, trailing: 0))
                            
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
                            } .padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
                        }
                        Divider()
                        LazyVStack(alignment: .leading) {
                            Text("Top Rated")
                                .font(.system(size: 22).bold())
                                .foregroundColor(.primary)
                            LazyVGrid(columns: columns) {
                                ForEach(viewModel.topRatedTvSeries) { row in
                                    NavigationLink {
                                        DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.tvGenres))
                                    } label: {
                                        TvSeriesCell(viewModel: TvSeriesCellViewModel(title: row, genreList: viewModel.tvGenres))
                                            .frame(height: geometryReader.size.height / 2.25)
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
}

struct TvSeriesView_Previews: PreviewProvider {
    static var previews: some View {
        TvSeriesView()
    }
}
