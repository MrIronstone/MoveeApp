//
//  TvSeriesCellViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.11.2022.
//

import Foundation

class TvSeriesCellViewModel: ObservableObject {
    let title: Title
    let genreList: GenreResponse
    
    init(title: Title, genreList: GenreResponse) {
        self.title = title
        self.genreList = genreList
    }
}
