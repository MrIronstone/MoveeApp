//
//  ListCellViewModel.swift
//  MoveeApp
//
//  Created by admin on 1.11.2022.
//

import Foundation

class ListCellViewModel: ObservableObject {
    @Published var isFavorite: Bool
    let title: Title
    let genreList: GenreResponse
    
        
    init(title: Title, genreList: GenreResponse) {
        self.title = title
        self.genreList = genreList
        isFavorite = FavoriteList.shared.checkIfThisTitleIsInTheFavs(selectedId: title.id)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkIfThisTitleIsInTheFavs),
            name: Notification.Name("favoritesChanged"),
            object: nil
        )
    }
    
    @objc public func checkIfThisTitleIsInTheFavs() -> Bool {
        isFavorite = FavoriteList.shared.checkIfThisTitleIsInTheFavs(selectedId: title.id)
        return isFavorite
    }
    
    public func changeTitleFavStatus() {
        FavoriteList.shared.addOrRemoveTitle(title: self.title)
        isFavorite.toggle()
    }
}
