//
//  ButtonAndResultView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import SwiftUI

struct MoviesView: View {
    @ObservedObject private var viewModel = MoviesViewModel()
    
    var body: some View {
        GeometryReader { geometryReader in
            NavigationStack {
                ScrollView {
                    VStack {
                        VStack {                  
                            ZStack {
                                Rectangle()
                                    .fill(.blue)
                                    .frame(
                                        width: geometryReader.size.width,
                                        height: geometryReader.size.height,
                                        alignment: .top
                                    )
                                    .background(Color.blue)
                                    .padding(EdgeInsets(top: -(geometryReader.size.height - 200), leading: 0, bottom: 0, trailing: 0))
                                
                                    
                                HStack {
                                    Text("Movies")
                                        .font(.system(size: 41).bold())
                                    Spacer()
                                    NavigationLink {
                                        MapView()
                                    } label: {
                                        Image(systemName: "map.circle.fill")
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(.white)
                                    }

                                }
                                .foregroundColor(Color.white)
                                .padding(.horizontal, 32)
                            }
                            /*
                            Rectangle()
                                .fill(.blue)
                                .frame(
                                    width: geometryReader.size.width,
                                    height: geometryReader.size.height,
                                    alignment: .top
                                )
                                .background(Color.blue)
                                .padding(EdgeInsets(top: -(geometryReader.size.height - 200), leading: 0, bottom: 0, trailing: 0))
                            HStack {
                                Text("Movies")
                                    .font(.system(size: 41).bold())
                                    .padding(EdgeInsets(top: -150, leading: -150, bottom: 0, trailing: 0))
                                    .foregroundColor(Color.white)
                                Spacer()
                                    .frame(width: 10)
                                NavigationLink {
                                    MapView()
                                } label: {
                                    Image(systemName: "power")
                                }

                            }
                            */
                            
                            
                            ScrollView(.horizontal) {
                                LazyHStack(spacing: 10) {
                                    ForEach(viewModel.nowPlayingMovies) { row in
                                        NavigationLink {
                                            DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.movieGenres))
                                        } label: {
                                            CardCellView(viewModel: CardCellViewModel(title: row, genreList: viewModel.movieGenres))
                                        }
                                    }
                                }
                            } .padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
                        }
                        Divider()
                        LazyVStack(alignment: .leading) {
                            Text("Popular")
                                .font(.system(size: 22).bold())
                                .foregroundColor(.primary)
                            ForEach(viewModel.populerMovies) { row in
                                NavigationLink {
                                    DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.movieGenres))
                                } label: {
                                    ListCellView(viewModel: ListCellViewModel(title: row, genreList: viewModel.movieGenres))
                                }
                            }
                        } .foregroundColor(Color.black)
                            .padding(EdgeInsets(top: 0, leading: 32, bottom: 0, trailing: 32))
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesView()
        MoviesView().preferredColorScheme(.dark)
    }
}
