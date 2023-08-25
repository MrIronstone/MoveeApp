//
//  SearchView.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 9.08.2023.
//

import SwiftUI
import Kingfisher

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                ScrollView {
                    LazyVStack {
                        ForEach(viewModel.data, id: \.self) { row in
                            SearchListItemView(viewModel: SearchListItemViewModel(content: row))
                        }
                        .padding(.horizontal)
                    }
                    .navigationBarTitleDisplayMode(.large)
                    .navigationTitle("Search")
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always))
            
            .onReceive(viewModel.$searchText.debounce(for: 0.5, scheduler: RunLoop.main), perform: { newValue in
                if newValue.count >= 3 {
                    viewModel.fetchSearchResult(query: newValue)
                }
            })
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
