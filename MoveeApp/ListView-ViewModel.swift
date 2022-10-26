//
//  ListView-ViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.10.2022.
//

import Foundation

extension ListView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var titles = ""
        
        public func fetchPopularMovies() {
            NetworkEngine.request(endpoint: TmdbEndpoint.getPopularMovies) { [weak self] (result: Result<TitlesResponse, Error>) in
                switch result {
                case .success(let success):
                    self?.titles = ""
                    for title in success.results {
                        guard let safeTitle = title.title else { return }
                        self?.titles += "\(safeTitle)\n"
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
        public func fetchNowPlayingMoviesList() {
            NetworkEngine.request(endpoint: TmdbEndpoint.getNowPlayingMovies) { [weak self] (result: Result<TitlesResponse, Error>) in
                switch result {
                case .success(let success):
                    self?.titles = ""
                    for title in success.results {
                        guard let safeTitle = title.title else { return }
                        self?.titles += "\(safeTitle)\n"
                    }
                case .failure(let failure):
                    print(failure.localizedDescription)
                }
            }
        }
        
        public func clearTitles() {
            self.titles = ""
        }
    }
}
