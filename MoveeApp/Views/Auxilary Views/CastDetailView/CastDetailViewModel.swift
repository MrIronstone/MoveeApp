//
//  CastDetailViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 5.08.2023.
//

import Foundation

class CastDetailViewModel: ObservableObject {
    @Published var person: Person?
    @Published var lineLength: Int = 5
    @Published var expandCollapseButtonText = "See full bio >>"
    @Published var titles: [Title] = []
    
    private let group = DispatchGroup()

    
    init(person: Person? = nil) {
        self.person = person
    }
    
    
    public func fetchCastDetails(castId: Int) {
        fetchCastPersonalDetails(castId: castId)
        fetchCombinedCredits(castId: castId)
        
        group.notify(queue: .main) { [weak self] in
            print("All processes finished")
            self?.sortTitlesByDate()
        }
    }
    
    private func sortTitlesByDate() {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(identifier: "UTC")
        
        let sortedArray = titles.sorted {
            formatter.date(from: $0.releaseDate ?? $0.firstAirDate ?? "") ?? Date() > formatter.date(from: $1.releaseDate ?? $1.firstAirDate ?? "") ?? Date()
        }
        
        let sortedAndFilteredArray = sortedArray.filter {
            formatter.date(from: $0.releaseDate ?? $0.firstAirDate ?? "") ?? Date() < Date.now
        }
        
        self.titles = sortedAndFilteredArray
        print("sorted and filtered titles")
    }
    
    private func fetchCastPersonalDetails(castId: Int) {
        NetworkEngine.request(endpoint: TmdbEndpoint.getCastDetails(id: castId)) { [weak self] (result: Result<Person, Error>) in
            switch result {
            case .success(let person):
                self?.person = person
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchCombinedCredits(castId: Int) {
        group.enter()
        NetworkEngine.request(endpoint: TmdbEndpoint.getCastCombinedCredits(id: castId)) { [weak self] (result: Result<PersonCreditsResponse, Error>) in
            switch result {
            case .success(let response):
                self?.titles = response.cast
                self?.group.leave()
            case.failure(let error):
                print(error.localizedDescription)
                self?.group.leave()
            }
        }
    }
    
    public func toggleBioLength() {
        if lineLength == 5 {
            lineLength = Int.max
            expandCollapseButtonText = "See less >>"
        } else {
            lineLength = 5
            expandCollapseButtonText = "See full bio >>"
        }
    }
}
