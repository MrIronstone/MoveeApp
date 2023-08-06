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
    
    init(person: Person? = nil) {
        self.person = person
    }
    
    public func fetchCastDetails(castId: Int) {
        NetworkEngine.request(endpoint: TmdbEndpoint.getCastDetails(id: castId)) { [weak self] (result: Result<Person, Error>) in
            switch result {
            case .success(let person):
                self?.person = person
            case .failure(let error):
                print(error.localizedDescription)
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
