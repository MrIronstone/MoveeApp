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
    
    let genreList: GenreResponse
    let titleType: TitleType
    
    init(title: Title, genreList: GenreResponse, titleType: TitleType) {
        self.title = title
        self.genreList = genreList
        self.titleType = titleType
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
        let endpoint = TmdbEndpoint.getMovieCredits(id: title.id)
        
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
}
