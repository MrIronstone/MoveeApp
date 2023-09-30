//
//  DetailViewModel.swift
//  MoveeApp
//
//  Created by admin on 1.11.2022.
//

import Foundation

class DetailViewModel: ObservableObject {
    @Published var title: Title
    @Published var director: String?
    @Published var writers: String?
    @Published var cast: [Person] = []
    @Published var isFavorite: Bool
    @Published var isRated: Bool
    @Published var rating: Int?
    
    let genreList: GenreResponse
    let titleType: TitleType
    
    init(title: Title, genreList: GenreResponse) {
        self.title = title
        self.genreList = genreList
        self.titleType = title.firstAirDate == nil ? .movie : .tvSeries
        
        isRated = FavoriteList.shared.checkIfThisTitleIsRated(selectedId: title.id)
        
        isFavorite = FavoriteList.shared.checkIfThisTitleIsInTheFavs(selectedId: title.id)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkIfThisTitleIsInTheFavs),
            name: Notification.Name("favoritesChanged"),
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(checkIfThisTitleHasRating),
            name: Notification.Name("ratedTitlesChanged"),
            object: nil
        )
    }
    
    public func fetchTitleDetails() {
        let endpoint = titleType == .tvSeries ?
        TmdbEndpoint.getTvSeriesDetails(id: title.id) :
        TmdbEndpoint.getMovieDetails(id: title.id)
        
        NetworkEngine.request(endpoint: endpoint) { [weak self] (result: Result<Title, Error>) in
            switch result {
            case .success(let success):
                self?.title = success
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    public func fetchDirectorAndWriter() {
        let endpoint = titleType == .tvSeries ?
        TmdbEndpoint.getTVSeriesCredits(id: title.id) :
        TmdbEndpoint.getMovieCredits(id: title.id)

        NetworkEngine.request(endpoint: endpoint) { [weak self] (result: Result<CreditsResponse, Error>) in
            switch result {
            case .success(let success):
                self?.cast = success.cast
                
                guard let safeDirector = success.crew.first(where: { $0.job == "Director" }) else { return }
                self?.director = safeDirector.name
                
                var writersStringArray: [String] = []
                for person in success.crew where person.job == "Writer" {
                    if let safeName = person.name {
                        writersStringArray.append(safeName)
                    }
                }
                self?.writers = writersStringArray.joined(separator: ", ")
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    @discardableResult
    @objc public func checkIfThisTitleIsInTheFavs() -> Bool {
        isFavorite = FavoriteList.shared.checkIfThisTitleIsInTheFavs(selectedId: title.id)
        return isFavorite
    }
    
    @discardableResult 
    @objc public func checkIfThisTitleHasRating() -> Bool {
        isRated = FavoriteList.shared.checkIfThisTitleIsRated(selectedId: title.id)
        return isRated
    }
    
    public func changeTitleFavStatus() {
        FavoriteList.shared.addOrRemoveTitle(title: self.title)
        isFavorite.toggle()
    }
    
    public func getLink() -> URL? {
        if title.firstAirDate != nil {
            guard let homepage = title.homepage else { return nil }
            return URL(string: homepage)
        } else {
            guard let imdbId = title.imdbId else { return nil }
            return URL(string: "https://www.imdb.com/title/\(imdbId)")
        }
    }
    
    public func addRating(rating: Int) {
        let request = [
            "value": Double((2 * rating))
        ]
        
        let endpoint = title.firstAirDate != nil ? TmdbEndpoint.addRatingToTVShow(seriesId: title.id) :
        TmdbEndpoint.addRatingToMovie(movieId: title.id)
        
        NetworkEngine.request(endpoint: endpoint, requestParameters: request) { [weak self] (result: Result<CreateSession, Error>) in
            guard let self else { return }
            switch result {
            case .success(let success):
                if success.success {
                    print("Succesfully added rating. \(rating) to \(self.title.name ?? self.title.title ?? "N/A")")
                    NotificationCenter.default.post(Notification(name: Notification.Name("rate")))
                }
            case .failure(let failure):
                print("Failure while trying to add rating. \(failure.localizedDescription)")
            }
        }
    }
    
    public func removeRating() {
        let endpoint = title.firstAirDate != nil ? TmdbEndpoint.removeRatingFromTVShow(seriesId: title.id) :
        TmdbEndpoint.removeRatingFromMovie(movieId: title.id)
        
        NetworkEngine.request(endpoint: endpoint) { (result: Result<CreateSession, Error>) in
            switch result {
            case .success(let success):
                if success.success {
                    print("Successfully removed the rating")
                    NotificationCenter.default.post(Notification(name: Notification.Name("rate")))
                }
            case .failure(let failure):
                print("Failure on remove rating: \(failure.localizedDescription)")
            }
        }
    }
}
