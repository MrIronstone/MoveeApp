//
//  ListView-ViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.10.2022.
//

import Foundation

class ListViewModel: ObservableObject {
    @Published var titles: [Title] = []
    
    init() {
        fetchPopularMovies()
    }
    
    public func fetchPopularMovies() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getPopularMovies) { [weak self] (result: Result<TitlesResponse, Error>) in
            switch result {
            case .success(let success):
                self?.titles = success.results
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func fetchNowPlayingMoviesList() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getNowPlayingMovies) { [weak self] (result: Result<TitlesResponse, Error>) in
            switch result {
            case .success(let success):
                self?.titles = success.results
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func clearTitles() {
        self.titles = [Title]()
    }
}
