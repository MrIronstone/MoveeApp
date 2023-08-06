//
//  TvSeriesEpisode.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 5.08.2023.
//


struct TvSeriesEpisode: Codable, Identifiable, Hashable {
    let id: Int
    let name: String?
    let overview: String?
    let voteAverage: Double?
    let voteCount: Int?
    let airDate: String?
    let episodeNumber: Int?
    let runtime: Int?
    let seasonNumber: Int?
}
