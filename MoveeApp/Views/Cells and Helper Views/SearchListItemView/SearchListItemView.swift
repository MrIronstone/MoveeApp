//
//  SearchListItemView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 11.08.2023.
//

import SwiftUI

struct SearchListItemView: View {
    @ObservedObject private var viewModel: SearchListItemViewModel
    
    init(viewModel: SearchListItemViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        switch viewModel.content {
        case .person(let person):
            NavigationLink {
                CastDetailView(viewModel: CastDetailViewModel(person: person))
            } label: {
                GenericListItemView(
                    viewModel: GenericListItemViewModel(
                        contentName: person.name ?? "",
                        customImageURL: person.profilePath ?? "",
                        contentSubtitle: viewModel.tempBornInfo,
                        contentIcon: "person",
                        contentIconText: "Actor"
                    )
                )
            }

        case .title(let title):
            NavigationLink {
                DetailView(viewModel: DetailViewModel(title: title, genreList: .example1()))
            } label: {
                GenericListItemView(
                    viewModel: GenericListItemViewModel(
                        contentName: title.getTitleName(),
                        customImageURL: title.posterPath ?? title.backdropPath ?? "",
                        contentSubtitle: viewModel.tempCastList,
                        contentIcon: title.firstAirDate == nil ? "film" : "tv",
                        contentIconText: title.firstAirDate == nil ? "Movie" : "TV Series"
                    )
                )
            }
        }
    }
}
