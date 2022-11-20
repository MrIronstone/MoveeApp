//
//  CardCellViewModel.swift
//  MoveeApp
//
//  Created by admin on 5.11.2022.
//

import Foundation

class CardCellViewModel: ObservableObject {
    let title: Title
    let genreList: GenreResponse
    
    init(title: Title, genreList: GenreResponse) {
        self.title = title
        self.genreList = genreList
    }
}
