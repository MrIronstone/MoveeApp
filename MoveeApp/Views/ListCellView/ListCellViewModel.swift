//
//  ListCellViewModel.swift
//  MoveeApp
//
//  Created by admin on 1.11.2022.
//

import Foundation

class ListCellViewModel: ObservableObject {
    let title: Title
    let genreList: GenreResponse
    
    init(title: Title, genreList: GenreResponse) {
        self.title = title
        self.genreList = genreList
    }
}
