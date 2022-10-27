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
        VStack {
            Button {
                viewModel.fetchPopularMovies()
            } label: {
                Label("Get Popular Movies", systemImage: "arrow.down.app.fill")
            } .buttonStyle(.borderedProminent)
            Text(viewModel.titles)
            Button {
                viewModel.fetchNowPlayingMoviesList()
            } label: {
                Label("Get Now Playin Movies", systemImage: "arrow.down.app.fill")
            } .buttonStyle(.borderedProminent)
            Button {
                viewModel.clearTitles()
            } label: {
                Text("Reset")
                    .foregroundColor(.red)
            }
        }
    }
}

struct ButtonAndResultView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
