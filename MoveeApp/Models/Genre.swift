//
//  Genre.swift
//  MoveeApp
//
//  Created by admin on 29.10.2022.
//

import Foundation

struct GenreResponse: Codable {
    let genres: [Genre]
    
    static func example1() -> GenreResponse {
        let genreResponse = GenreResponse(genres: [
            Genre(id: 28, name: "Action"),
            Genre(id: 12, name: "Adventure"),
            Genre(id: 16, name: "Animation"),
            Genre(id: 35, name: "Comedy"),
            Genre(id: 80, name: "Crime"),
            Genre(id: 99, name: "Documentary"),
            Genre(id: 18, name: "Drama"),
            Genre(id: 10751, name: "Family"),
            Genre(id: 14, name: "Fantasy"),
            Genre(id: 36, name: "History"),
            Genre(id: 27, name: "Horror"),
            Genre(id: 10402, name: "Musiv"),
            Genre(id: 9648, name: "Mystery"),
            Genre(id: 10749, name: "Romance"),
            Genre(id: 878, name: "Science Ficton"),
            Genre(id: 10770, name: "TV Movie"),
            Genre(id: 53, name: "Thriller"),
            Genre(id: 10752, name: "War"),
            Genre(id: 37, name: "Western")
        ])
        return genreResponse
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
    
    static func example() -> Genre {
        let genre = Genre(
            id: 28,
            name: "Action"
        )
        return genre
    }
}
