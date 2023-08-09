//
//  TmdbEndpoint.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.10.2022.
//

import Foundation

enum TmdbEndpoint: Endpoint {
    case getPopularMovies
    case getNowPlayingMovies
    case getMovieGenreList
    case getImage(path: String, imageRes: ImageRes)
    
    case getPopularTvSeries
    case getTopRatedTvSeries
    case getTvSeriesGenreList
    
    case getTvSeriesDetails(id: Int)
    case getMovieDetails(id: Int)
    
    case getTVSeriesCredits(id: Int)
    case getMovieCredits(id: Int)
    
    case getCastDetails(id: Int)
    
    case getCastMovieCredits(id: Int)
    case getCastTVSeriesCredits(id: Int)
    
    case getCastCombinedCredits(id: Int)
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        case .getImage:
            return "image.tmdb.org"
        default:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/3/movie/popular"
        case .getNowPlayingMovies:
            return "/3/movie/now_playing"
        case .getMovieGenreList:
            return "/3/genre/movie/list"
        case let .getImage(path, imageRes):
            switch imageRes {
            case .lowRes:
                return "/t/p/w500\(path)"
            case .highRes:
                return "/t/p/original\(path)"
            }
        case .getPopularTvSeries:
            return "/3/tv/popular"
        case .getTopRatedTvSeries:
            return "/3/tv/top_rated"
        case .getTvSeriesGenreList:
            return "/3/genre/tv/list"
        case let .getTvSeriesDetails(id):
            return "/3/tv/\(id)"
        case let .getMovieDetails(id):
            return "/3/movie/\(id)"
        case let.getTVSeriesCredits(id):
            return "/3/tv/\(id)/credits"
        case let .getMovieCredits(id):
            return "/3/movie/\(id)/credits"
        case let .getCastDetails(id):
            return "/3/person/\(id)"
        case let .getCastMovieCredits(id):
            return "/3/person/\(id)/movie_credits"
        case let .getCastTVSeriesCredits(id):
            return "/3/person/\(id)/tv_credits"
        case let .getCastCombinedCredits(id):
            return "/3/person/\(id)/combined_credits"
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "d6715ac27b93b285c4c33a3ce1e485b9"
        
        switch self {
        default:
            return [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        }
    }
    
    var method: String {
        switch self {
        default:
            return "GET"
        }
    }
    
    
    func returnUrlAsString() -> String {
        var components = URLComponents()
        components.scheme = self.scheme
        components.host = self.baseURL
        components.path = self.path
        components.queryItems = self.parameters
        
        // 3
        guard let url = components.url else { return "" }
        
        return url.absoluteString
    }
}
