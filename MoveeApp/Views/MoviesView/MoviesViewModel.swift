//
//  ListView-ViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.10.2022.
//

import Foundation

class MoviesViewModel: ObservableObject {
    @Published var populerMovies: [Title] = []
    @Published var nowPlayingMovies: [Title] = []
    @Published var movieGenres: GenreResponse = GenreResponse(genres: [])
    
    init() {
        fetchPopularMovies()
        fetchNowPlayingMoviesList()
        fetchMovieGenreList()
    }
    
    public func fetchPopularMovies() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getPopularMovies) { [weak self] (result: Result<TitlesResponse, Error>) in
            switch result {
            case .success(let success):
                self?.populerMovies = success.results
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func fetchNowPlayingMoviesList() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getNowPlayingMovies) { [weak self] (result: Result<TitlesResponse, Error>) in
            switch result {
            case .success(let success):
                self?.nowPlayingMovies = success.results
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func fetchMovieGenreList() {
        NetworkEngine.request(endpoint: TmdbEndpoint.getMovieGenreList) { [weak self] (result: Result<GenreResponse, Error>) in
            switch result {
            case .success(let succededGenreResponse):
                self?.movieGenres = succededGenreResponse
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    public func clearTitles() {
        self.populerMovies = [Title]()
        self.nowPlayingMovies = [Title]()
    }
}
