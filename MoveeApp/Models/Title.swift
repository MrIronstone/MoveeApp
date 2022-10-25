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
    let backdrop_path: String?
    let id: Int
    let media_type: String?
    let original_language: String?
    let original_title: String?
    let name: String?
    let title: String?
    let popularity: Double?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let vote_average: Double?
    let vote_count: Int?
}
