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
    
    static func example2() -> Title {
        let exampleTitle = Title(
            backdropPath: "/2OMB0ynKlyIenMJWI2Dy9IWT4c.jpg",
            id: 1399,
            imdbId: nil,
            revenue: nil,
            runtime: nil,
            firstAirDate: "2011-04-17",
            lastEpisodeToAir: TvSeriesEpisode(
                id: 1551830,
                name: "The Iron Throne",
                overview: "In the aftermath of the devastating attack on King's Landing, Daenerys must face the survivors.",
                voteAverage: 4.77,
                voteCount: 244,
                airDate: "2019-05-19",
                episodeNumber: 6,
                runtime: 80,
                seasonNumber: 8
            ),
            createdBy: [
                Person(
                    id: 9813,
                    creditId: "5256c8c219c2956ff604858a",
                    imdbId: "asdasd",
                    name: "David Benioff",
                    originalName: nil,
                    profilePath: "/xvNN5huL0X8yJ7h3IZfGG4O2zBD.jpg",
                    biography: "bla bla bla bla bla",
                    placeOfBirth: "bla bla bla bla",
                    birtday: nil,
                    deathday: nil,
                    knownForDepartment: nil,
                    popularity: nil,
                    castId: nil,
                    character: nil,
                    order: nil,
                    department: nil,
                    job: nil
                ),
                Person(
                    id: 228068,
                    creditId: "552e611e9251413fea000901",
                    imdbId: nil,
                    name: "D.B. Weiss",
                    originalName: nil,
                    profilePath: "/2RMejaT793U9KRk2IEbFfteQntE.jpg",
                    biography: "nil nil nil n ilnil nil",
                    placeOfBirth: "nil nil nil nil / nil nil",
                    birtday: nil,
                    deathday: nil,
                    knownForDepartment: nil,
                    popularity: nil,
                    castId: nil,
                    character: nil,
                    order: nil,
                    department: nil,
                    job: nil
                )
            ],
            genres: [
                Genre(
                    id: 10765,
                    name: "Sci-Fi & Fantasy"
                ),
                Genre(
                    id: 18,
                    name: "Drama"
                ),
                Genre(
                    id: 10759,
                    name: "Action & Adventure"
                )
            ],
            genreIds: nil,
            originalLanguage: "en",
            originalTitle: nil,
            name: "Game of Thrones",
            title: nil,
            popularity: 377.251,
            posterPath: "/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg",
            // swiftlint:disable line_length
            overview: "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
            // swiftlint:enable line_length
            releaseDate: nil,
            voteAverage: 8.439,
            voteCount: 21523
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
        if let safeDate = self.releaseDate, !safeDate.isEmpty {
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
