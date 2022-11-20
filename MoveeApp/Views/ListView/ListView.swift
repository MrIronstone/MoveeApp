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
            ScrollView {
                VStack {
                    VStack {
                        Text("Movies")
                            .font(.system(size: 41).bold())
                            .padding(EdgeInsets(top: 150, leading: -150, bottom: 0, trailing: 0))
                            .foregroundColor(Color.white)
                            .frame(width: 400, height: 300, alignment: .top)
                            .background(Color.blue)
                            .padding(EdgeInsets(top: -100, leading: 0, bottom: 0, trailing: 0))
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 10) {
                                ForEach(viewModel.nowPlayingMovies) { row in
                                    NavigationLink {
                                        DetailView(viewModel: DetailViewModel(title: row, genreList: viewModel.movieGenres))
                                    } label: {
                                        CardCellView(viewModel: CardCellViewModel(title: row, genreList: viewModel.movieGenres))
                                    }
                                }
                            }
                        } .padding(EdgeInsets(top: -70, leading: 0, bottom: 0, trailing: 0))
                    }
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Popular")
                            .font(.system(size: 22).bold())
                        
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

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
