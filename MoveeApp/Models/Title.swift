//
//  File.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import Foundation
import SwiftUI

struct TitlesResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Hashable, Identifiable {
    let backdropPath: String?
    let id: Int
    let genreIds: [Int?]?
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
        case genreIds = "genre_ids"
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
            genreIds: [25, 53],
            originalLanguage: "en",
            originalTitle: "Terrifier 2",
            name: "Terrifier 2",
            title: "Terrifier 2 Terrifier 2 Terrifier 2 Terrifier 2 Terrifier 2 Terrifier 2 ",
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

extension Title {
    func getGenreString(with genreList: GenreResponse) -> String {
        var genres: [String] = []
        guard let safeTitleGenreList = self.genreIds else { return "" }
        for genre in genreList.genres where safeTitleGenreList.contains(genre.id) {
            genres.append(genre.name)
        }
        return genres.joined(separator: ", ")
    }
    
    func getNewDateStyle() -> String {
        if let safeDate = self.releaseDate {
            let year = safeDate.components(separatedBy: "-")[0]
            let month = safeDate.components(separatedBy: "-")[1]
            let day = safeDate.components(separatedBy: "-")[2]
            let newDate = "\(day).\(month).\(year)"
            return newDate
        }
        return "01.01.1900"
    }
    
    func getTitleName() -> String {
        self.title ?? self.name ?? "Unknown Title"
    }
    
    func getVoteAverage() -> String {
        guard let safeVoteAverage = self.voteAverage else { return "0.0"}
        let newVoteAverage = String(format: "%.1f", safeVoteAverage )
        return newVoteAverage
    }
}


struct Title_Previews: PreviewProvider {
    static var previews: some View {
        CardCellView(viewModel: CardCellViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
