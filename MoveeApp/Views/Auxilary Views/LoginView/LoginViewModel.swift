//
//  LoginViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 3.09.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    
    @Published var errorMessage: String = ""
    
    @Published var auth: CreateSession?
    
    public func login(completion: @escaping (Result<CreateSession, Error>) -> Void) {
        requestToken { [weak self] (result: Result<CreateToken, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let success):
                let dict = [
                    "username": "\(self.username)",
                    "password": "\(self.password)",
                    "request_token": "\(success.requestToken)"
                ]
                
                NetworkEngine.request(
                    endpoint: TmdbEndpoint.validateWithLogin,
                    requestParameters: dict) { [weak self] (result: Result<AuthorizeToken, Error>) in
                    guard let self else { return }
                    switch result {
                    case .success(let successfulResult):
                        switch successfulResult.success {
                        case true:
                            // Create a Session
                            guard let requestToken = successfulResult.requestToken else { return }
                            let sessionDict = [
                                "request_token": "\(requestToken)"
                            ]
                            NetworkEngine.request(
                                endpoint: TmdbEndpoint.createNewSession,
                                requestParameters: sessionDict) { [weak self] (result: Result<CreateSession, Error>) in
                                guard let self else { return }
                                switch result {
                                case .success(let successfulCreateSessionResponse):
                                    switch successfulCreateSessionResponse.success {
                                    case true:
                                        // successfull login
                                        guard let sessionId = successfulCreateSessionResponse.sessionId else { return }
                                        self.auth = successfulCreateSessionResponse
                                        UserDefaults.standard.set(sessionId, forKey: "sessionId")
                                        completion(.success(successfulCreateSessionResponse))
                                    case false:
                                        guard let statusMessage = successfulResult.statusMessage else { return }
                                        print("Error on creating session: \(statusMessage)")
                                        let error = NSError(domain: statusMessage, code: -1002)
                                        completion(.failure(error))
                                    }
                                case .failure(let error):
                                    print("Error on creating session: \(error)")
                                    let error = NSError(domain: error.localizedDescription, code: -1002)
                                    completion(.failure(error))
                                }
                            }
                        case false:
                            guard let statusMessage = successfulResult.statusMessage else { return }
                            self.errorMessage = "Error on login: \(statusMessage)"
                            print("Error on login: \(statusMessage)")
                            let error = NSError(domain: statusMessage, code: -1001)
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print(self.errorMessage)
                    }
                }
                /*
                NetworkEngine.request(
                    endpoint: TmdbEndpoint.validateWithLogin(
                        username: self.username,
                        password: self.password,
                        token: success.requestToken
                    )
                ) { [weak self] (result: Result<LoginResponseModel, Error>) in
                    guard let self = self else { return }

                    switch result {
                    case .success(let success):
                        self.auth = success
                        switch success.success {
                        case true:
                            completion(.success(success))
                        case false:
                            self.errorMessage = "Error on login: \(success.statusMessage)"
                            print("Error on login: \(success.statusMessage)")
                            let error = NSError(domain: success.statusMessage ?? "N/A", code: -1001)
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        self.username = ""
                        self.password = ""
                        self.errorMessage = "Error while requesting token \(error.localizedDescription)"
                        print("Error while validating login: \(error.localizedDescription)")
                    }
                }
                 */
            case .failure(let error):
                self.username = ""
                self.password = ""
                self.errorMessage = "Error while requesting token \(error.localizedDescription)"
                print(self.errorMessage)
            }
        }
    }
    
    private func requestToken(completion: @escaping (Result<CreateToken, Error>) -> Void) {
        NetworkEngine.request(endpoint: TmdbEndpoint.createReqeustToken) { (result: Result<CreateToken, Error>) in
            switch result {
            case .success(let createTokenResponseModel):
                completion(.success(createTokenResponseModel))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
