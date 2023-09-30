//
//  FavoriteListSingleton.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 17.09.2023.
//

import Foundation

class FavoriteList: ObservableObject {
    @Published var favList = [Title]()
    @Published var ratedList = [Title]()
    
    private var movieFavList = [Title]()
    private var tvSeriesFavList = [Title]()
    
    private var ratedMovieList = [Title]()
    private var ratedTVShowList = [Title]()
    
    static let shared = FavoriteList()
    
    let group = DispatchGroup()
    
    let rateGroup = DispatchGroup()
    
    private init() {
        getFavorites()
        getRatedTitles()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getFavorites),
            name: Notification.Name("favorite"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(getRatedTitles),
            name: Notification.Name("rate"),
            object: nil
        )
    }
    
    @objc func getFavorites() {
        getFavoriteTVShows()
        getFavoriteMovies()
        
        group.notify(queue: .main) {
            self.favList = self.tvSeriesFavList + self.movieFavList
            print("Gathered all fav titles and count \(self.favList.count)")
        }
    }
    
    @objc func getRatedTitles() {
        getRatedMovies()
        getRatedTVShows()
        
        rateGroup.notify(queue: .main) {
            self.ratedList = self.ratedMovieList + self.ratedTVShowList
            print("Gathered all rated titles and count \(self.ratedList.count)")
            NotificationCenter.default.post(Notification(name: Notification.Name("ratedTitlesChanged")))
        }
    }
    
    private func getRatedMovies() {
        rateGroup.enter()
        
        let endpoint = TmdbEndpoint.getRatedMovies
        
        NetworkEngine.request(endpoint: endpoint) { (result: Result<FavoritesResponse, Error>) in
            switch result {
            case .success(let success):
                guard let results = success.results else { return }
                self.ratedMovieList = results
                print("Retreived rated movies successfully. Count: \(results.count)")
                self.rateGroup.leave()
            case .failure(let failure):
                print("Failed to get rated movies. \(failure.localizedDescription).")
                self.rateGroup.leave()
            }
        }
    }
    
    private func getRatedTVShows() {
        rateGroup.enter()
        
        let endpoint = TmdbEndpoint.getRatedTVShows
        
        NetworkEngine.request(endpoint: endpoint) { (result: Result<FavoritesResponse, Error>) in
            switch result {
            case .success(let success):
                guard let results = success.results else { return }
                self.ratedTVShowList = results
                print("Retreived rated tv shows successfully. Count: \(results.count)")
                self.rateGroup.leave()
            case .failure(let failure):
                print("Failed to get rated tv shows. \(failure.localizedDescription).")
                self.rateGroup.leave()
            }
        }
    }
    
    private func getFavoriteMovies() {
        group.enter()
        let endpoint = TmdbEndpoint.getFavoriteMovies
        
        NetworkEngine.request(endpoint: endpoint) { [weak self] (result: Result<FavoritesResponse, Error>) in
            guard let self else { return }
            switch result {
            case .success(let success):
                guard let results = success.results else { return }
                self.movieFavList = results
                print("Retreived favorites movies successfully. Count: \(results.count)")
                self.group.leave()
            case .failure(let failure):
                print("Failed to get favorites movies." +
                      " \(failure.localizedDescription)." +
                      " Session ID is: " +
                      " \(String(describing: UserDefaults.standard.string(forKey: "sessionId")))")
                self.group.leave()
            }
        }
    }
    
    private func getFavoriteTVShows() {
        group.enter()
        let endpoint = TmdbEndpoint.getFavoriteTVShows
        
        NetworkEngine.request(endpoint: endpoint) { [weak self] (result: Result<FavoritesResponse, Error>) in
            guard let self else { return }
            switch result {
            case .success(let success):
                // successful results
                guard let results = success.results else { return }
                self.tvSeriesFavList = results
                print("Retreived favorites tv shows successfully. Count:\(results.count).")
                self.group.leave()
            case .failure(let failure):
                // failure
                print("Failed to get favorites tv shows." +
                      " \(failure.localizedDescription)." +
                      " Session ID is: " +
                      " \(String(describing: UserDefaults.standard.string(forKey: "sessionId")))")
                self.group.leave()
            }
        }
    }
    
    public func checkIfThisTitleIsInTheFavs(selectedId: Int) -> Bool {
        favList.contains { title in
            title.id == selectedId
        }
    }
    
    public func checkIfThisTitleIsRated(selectedId: Int) -> Bool {
        ratedList.contains { title in
            title.id == selectedId
        }
    }
    
    public func getTheRatedTitlesRating(selectedId: Int) -> Int? {
        if checkIfThisTitleIsRated(selectedId: selectedId) {
            if let title = ratedList.first(where: { title in title.id == selectedId }) {
                return title.rating
            }
        }
        return nil
    }
    
    private func addTitle(selectedTitle: Title) {
        if !favList.contains(where: { title in
            title.id == selectedTitle.id
        }) {
            // only add if it isn't already favorite
            favList.append(selectedTitle)
        }
    }
    
    private func removeTitle(selectedTitle: Title) {
        favList.removeAll { title in
            title.id == selectedTitle.id
        }
    }
    
    public func addOrRemoveTitle(title: Title) {
        let status = FavoriteList.shared.checkIfThisTitleIsInTheFavs(selectedId: title.id)
        
        if status {
            FavoriteList.shared.removeTitle(selectedTitle: title)
        } else {
            FavoriteList.shared.addTitle(selectedTitle: title)
        }
        
        let mediaType: String = title.firstAirDate != nil ? "tv" : "movie"
        let parameters = [
            "media_type": "\(mediaType)",
            "media_id": title.id,
            "favorite": !status
        ] as [String: Any]
        
        NetworkEngine.request(endpoint: TmdbEndpoint.addOrRemoveFromTheFavorite, requestParameters: parameters) { (result: Result<CreateSession, Error>) in
            switch result {
            case .success(let response):
                if response.success {
                    print("Successfully added/removed item. New status of \(title.name ?? title.title ?? "N/A") is \(!status)")
                    NotificationCenter.default.post(Notification(name: Notification.Name("favoritesChanged")))
                } else {
                    print("Something went wrong and couldn't remove/add item. \(title.name ?? title.title ?? "N/A")")
                }
            case .failure(let error):
                print("Error while adding/removing favorite. Error: \(error.localizedDescription)")
            }
        }
    }
}
