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

struct Title: Codable, Hashable, Identifiable {
    let backdropPath: String?
    let id: Int
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
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case name = "name"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case overview = "overview"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    static func example1() -> Title {
        let exampleTitle = Title(
            backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
            id: 663712,
            originalLanguage: "en",
            originalTitle: "Terrifier 2",
            name: "Terrifier 2",
            title: "Terrifier 2",
            popularity: 5086.332,
            posterPath: "/yw8NQyvbeNXoZO6v4SEXrgQ27Ll.jpg",
            overview: "After being resurrected by a sinister entity, Art the Clown returns to Miles County where he must hunt",
            releaseDate: "2022-10-06",
            voteAverage: 7.6,
            voteCount: 159
        )
        return exampleTitle
    }
}
