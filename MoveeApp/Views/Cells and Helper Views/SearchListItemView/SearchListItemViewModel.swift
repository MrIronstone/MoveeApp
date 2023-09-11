//
//  SearchListItemViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 11.08.2023.
//

import Foundation

class SearchListItemViewModel: ObservableObject {
    var content: Content
    @Published var tempCastList = ""
    @Published var tempBornInfo = ""

    
    init(content: Content) {
        self.content = content
        
        switch content {
        case .title(let title):
            fetchCastList(title: title)
        case .person(let person):
            fetchCastBornDetails(personId: person.id)
        }
    }
    
    public func fetchCastBornDetails(personId: Int) {
        let endpoint = TmdbEndpoint.getCastDetails(id: personId)
        
        NetworkEngine.request(endpoint: endpoint) { [weak self] (result: Result<Person, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.tempBornInfo = (self.combineInfos(response: success))
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func combineInfos(response: Person) -> String {
        guard let birthDay = response.birthday else { return ""}
        let birthDayString = formattedBirthDate(birthday: birthDay)
        guard let birthPlace = response.placeOfBirth else { return ""}
        let birthPlaceString = birthPlace.split(separator: ", ").last
        let finalString = "Born: \(birthDayString) in \(birthPlaceString ?? "")"
        return finalString
    }
    
    func formattedBirthDate(birthday: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = dateFormatter.date(from: birthday) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM d, yyyy"
            return outputFormatter.string(from: date)
        } else {
            return ""
        }
    }
    
    public func fetchCastList(title: Title) {
        let endpoint = title.firstAirDate != nil ?
        TmdbEndpoint.getTVSeriesCredits(id: title.id) :
        TmdbEndpoint.getMovieCredits(id: title.id)
        
        NetworkEngine.request(endpoint: endpoint) { [weak self] (result: Result<CreditsResponse, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                self.tempCastList = self.combineCastList(response: success)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    private func combineCastList(response: CreditsResponse) -> String {
        var casts: [String] = []
        
        for cast in response.cast {
            guard let castName = cast.name else { return ""}
            casts.append(castName)
        }
        
        return casts.joined(separator: ", ")
    }
}
