//
//  DetailViewModel.swift
//  MoveeApp
//
//  Created by admin on 1.11.2022.
//

import Foundation

class DetailViewModel: ObservableObject {
    let title: Title
    let genreList: GenreResponse
    
    init(title: Title, genreList: GenreResponse) {
        self.title = title
        self.genreList = genreList
    }
    
    func getGenreString() -> String {
        var genres: [String] = []
        guard let safeTitleGenreList = title.genreIds else { return "" }
        for genre in genreList.genres where safeTitleGenreList.contains(genre.id) {
            genres.append(genre.name)
        }
        return genres.joined(separator: ", ")
    }
    
    func getNewDateStyle() -> String {
        if let safeDate = title.releaseDate {
            let year = safeDate.components(separatedBy: "-")[0]
            let month = safeDate.components(separatedBy: "-")[1]
            let day = safeDate.components(separatedBy: "-")[2]
            let newDate = "\(day).\(month).\(year)"
            return newDate
        }
        return "01.01.1900"
    }
    
    func getTitleName() -> String {
        guard let safeTitleName = title.title else { return "Unknown Title"}
        return safeTitleName
    }
    
    func getVoteAverage() -> String {
        guard let safeVoteAverage = title.voteAverage else { return "0.0"}
        let newVoteAverage = String(format: "%.1f", safeVoteAverage )
        return newVoteAverage
    }
}
