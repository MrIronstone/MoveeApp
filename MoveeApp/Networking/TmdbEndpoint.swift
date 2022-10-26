//
//  TmdbEndpoint.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.10.2022.
//

import Foundation

enum TmdbEndpoint: Endpoint {
    case getPopularMovies
    
    var scheme: String {
        switch self {
        default:
            return "https"
        }
    }
    
    var baseURL: String {
        switch self {
        default:
            return "api.themoviedb.org"
        }
    }
    
    var path: String {
        switch self {
        case .getPopularMovies:
            return "/3/movie/popular"
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "d6715ac27b93b285c4c33a3ce1e485b9"
        
        switch self {
        case .getPopularMovies:
            return [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        }
    }
    
    var method: String {
        switch self {
        case .getPopularMovies:
            return "GET"
        }
    }
}
