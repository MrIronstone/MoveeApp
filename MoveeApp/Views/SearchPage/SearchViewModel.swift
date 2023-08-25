//
//  SearchViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 9.08.2023.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    @Published var data: [Content] = []
    @Published var searchText = ""
    
    private var delayBetweenQueries = 0.5
    private var query: String = ""

    private var page = 1
    
    public func fetchSearchResult(query: String) {
        self.query = query
        NetworkEngine.request(endpoint: TmdbEndpoint.getSearchResult(query: query, page: page)) { [weak self] (result: Result<SearchResponse, Error>) in
            switch result {
            case .success(let success):
                self?.data = success.results ?? []
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
