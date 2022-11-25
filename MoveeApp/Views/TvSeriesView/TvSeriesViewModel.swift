//
//  TvSeriesViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 24.11.2022.
//

import SwiftUI

class TvSeriesViewModel: ObservableObject {
    @Published var populerTvSeries: [Title] = []
    @Published var topRatedTvSeries: [Title] = []
    @Published var tvGenres: GenreResponse = GenreResponse(genres: [])
    
    init() {
        fetchPopularTvSeries()
        fetchTopRatedTvSeries()
        fetchTvGenreList()
    }
    
    public func fetchPopularTvSeries() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getPopularTvSeries) { [weak self] (result: Result<TitlesResponse, Error>) in
            switch result {
            case .success(let success):
                self?.populerTvSeries = success.results
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func fetchTopRatedTvSeries() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getTopRatedTvSeries) { [weak self] (result: Result<TitlesResponse, Error>) in
            switch result {
            case .success(let success):
                self?.topRatedTvSeries = success.results
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func fetchTvGenreList() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getTvSeriesGenreList) { [weak self] (result: Result<GenreResponse, Error>) in
            switch result {
            case .success(let succededGenreResponse):
                self?.tvGenres = succededGenreResponse
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func clearTitles() {
        self.populerTvSeries = [Title]()
        self.topRatedTvSeries = [Title]()
    }
}
