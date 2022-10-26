//
//  File.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import Foundation

struct TitlesResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Hashable {
    let backdropPath: String?
    let id: Int
    let mediaType: String?
    let originalLanguage: String?
    let originalTitle: String?
    let name: String?
    let title: String?
    let popularity: Double?
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let voteAverage: Double?
    let voteCount: Int?
}
