//
//  NetworkManager.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 25.10.2022.
//

import Foundation


struct Constants {
    static let apiKey = "d6715ac27b93b285c4c33a3ce1e485b9"
    static let baseURL = "https://api.themoviedb.org"
    static let populerMovies = "movie/popular"
}

enum NetworkManagerError: Error {
    case failedToGetData
}

class NetworkManager: ObservableObject {
    static let shared = NetworkManager()
    
        
    public func getPopularMovies(completion: @escaping (Result<[Title], Error >) -> Void) {
        getTitles(with: Constants.populerMovies) { result in
            switch result {
            case .success(let success):
                completion(.success(success))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    
    private func getTitles(with subUrl: String, completion: @escaping (Result<[Title], Error >) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/\(subUrl)?api_key=\(Constants.apiKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url), completionHandler: { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let results = try JSONDecoder().decode(TitlesResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(NetworkManagerError.failedToGetData))
            }
        })
        
        task.resume()
    }
}
