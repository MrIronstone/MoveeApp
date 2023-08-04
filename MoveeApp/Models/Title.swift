//
//  File.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import SwiftUI

struct TitlesResponse: Codable {
    let results: [Title]
}

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

struct Title: Codable, Hashable, Identifiable {
    let backdropPath: String?
    let id: Int
    let imdbId: String?
    let revenue: Int?
    let runtime: Int?
    let firstAirDate: String?
    let lastEpisodeToAir: TvSeriesEpisode?
    let createdBy: [Person?]?
    let genres: [Genre?]?
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
        
    static func example1() -> Title {
        let exampleTitle = Title(
            backdropPath: "/y5Z0WesTjvn59jP6yo459eUsbli.jpg",
            id: 663712,
            imdbId: "1",
            revenue: 1,
            runtime: 122,
            firstAirDate: nil,
            lastEpisodeToAir: nil,
            createdBy: nil,
            genres: [],
            genreIds: [25, 53],
            originalLanguage: "en",
            originalTitle: "Terrifier 2",
            name: "Terrifier 2",
            title: "Terrifier 2 ",
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
        
        if let safeTitleGenreList = self.genreIds {
            for genre in genreList.genres where safeTitleGenreList.contains(genre.id) {
                genres.append(genre.name)
            }
            return genres.joined(separator: ", ")
        }
        
        if let safeGenreList = self.genres {
            for genre in safeGenreList {
                genres.append(genre?.name ?? "")
            }
            return genres.joined(separator: ", ")
        }
        return ""
    }
    
    func getNewDateStyle() -> String {
        if let safeDate = self.releaseDate {
            let year = safeDate.components(separatedBy: "-")[0]
            let month = safeDate.components(separatedBy: "-")[1]
            let day = safeDate.components(separatedBy: "-")[2]
            let newDate = "\(day).\(month).\(year)"
            return newDate
        }
        if let safeDate = self.firstAirDate {
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
    
    func getDuration() -> String {
        if let safeRuntime = self.runtime {
            return "\(safeRuntime) min"
        }
        if let safeLastEpisode = self.lastEpisodeToAir {
            guard let safeRuntime = safeLastEpisode.runtime else { return "0 min"}
            return "\(safeRuntime) min"
        }
        return "0 min"
    }
    
    func getCreatorList() -> String {
        var producers: [String] = []
        
        if let safeProducerList = self.createdBy {
            for producer in safeProducerList {
                guard let producer = producer else { return "" }
                guard let producerName = producer.name else { return ""}
                producers.append(producerName)
            }
            return producers.joined(separator: ", ")
        }
        return ""
    }
}


struct Title_Previews: PreviewProvider {
    static var previews: some View {
        CardCellView(viewModel: CardCellViewModel(title: Title.example1(), genreList: GenreResponse.example1()))
    }
}
