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
    
    case getSearchResult(query: String, page: Int)
    
    case createReqeustToken
    case validateWithLogin
    case createNewSession
    case deleteSession
    
    case accountDetail(sessionId: String)
    
    case getFavoriteMovies
    case getFavoriteTVShows
    
    case addOrRemoveFromTheFavorite
    
    case addRatingToMovie(movieId: Int)
    case removeRatingFromMovie(movieId: Int)
    
    case addRatingToTVShow(seriesId: Int)
    case removeRatingFromTVShow(seriesId: Int)
    
    case getRatedMovies
    case getRatedTVShows
        
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
        let accountId = UserDefaults.standard.integer(forKey: "accountId")

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
        case .getSearchResult:
            return "/3/search/multi"
        case .createReqeustToken:
            return "/3/authentication/token/new"
        case .validateWithLogin:
            return "/3/authentication/token/validate_with_login"
        case .createNewSession:
            return "/3/authentication/session/new"
        case .deleteSession:
            return "/3/authentication/session"
        case .accountDetail:
            return "/3/account"
        case .getFavoriteMovies:
            return "/3/account/\(accountId)/favorite/movies"
        case .getFavoriteTVShows:
            return "/3/account/\(accountId)/favorite/tv"
        case .addOrRemoveFromTheFavorite:
            if accountId == 0 {
                fatalError("No account Found")
            }
            return "/3/account/\(accountId)/favorite"
        case .addRatingToTVShow(let seriesId), .removeRatingFromTVShow(let seriesId):
            return "/3/tv/\(seriesId)/rating"
        case .addRatingToMovie(movieId: let movieId), .removeRatingFromMovie(movieId: let movieId):
            return "/3/movie/\(movieId)/rating"
        case .getRatedMovies:
            if accountId == 0 {
                fatalError("No account Found")
            }
            return "/3/account/\(accountId)/rated/movies"
        case .getRatedTVShows:
            if accountId == 0 {
                fatalError("No account Found")
            }
            return "/3/account/\(accountId)/rated/tv"
        }
    }
    
    var parameters: [URLQueryItem] {
        let apiKey = "d6715ac27b93b285c4c33a3ce1e485b9"
        
        switch self {
        case let .getSearchResult(query, page):
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "query", value: query),
                URLQueryItem(name: "page", value: String(page))
            ]
        case .accountDetail,
                .getFavoriteMovies,
                .getFavoriteTVShows,
                .addOrRemoveFromTheFavorite,
                .addRatingToMovie,
                .removeRatingFromMovie,
                .addRatingToTVShow,
                .removeRatingFromTVShow,
                .getRatedMovies,
                .getRatedTVShows:
            guard let sessionId = UserDefaults.standard.string(forKey: "sessionId") else { return [] }
            return [
                URLQueryItem(name: "session_id", value: String(sessionId)),
                URLQueryItem(name: "api_key", value: String(apiKey))
            ]
        default:
            return [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        }
    }
    
    var method: String {
        switch self {
        case .validateWithLogin, .createNewSession, .addOrRemoveFromTheFavorite, .addRatingToMovie, .addRatingToTVShow:
            return "POST"
        case .deleteSession, .removeRatingFromMovie, .removeRatingFromTVShow:
            return "DELETE"
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
