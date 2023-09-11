//
//  Authentication.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 4.09.2023.
//

import Foundation

class Authentication: ObservableObject {
    @Published var response: CreateSession = CreateSession(success: false, failure: nil, statusCode: nil, statusMessage: nil, sessionId: nil)
    
    init() {
        if let sessionId = UserDefaults.standard.string(forKey: "sessionId") {
            response = CreateSession(success: true, failure: nil, statusCode: nil, statusMessage: nil, sessionId: sessionId)
        }
    }
    
    func changeAuthenticateState(state: CreateSession) {
        self.response = state
    }
    
    func removeAuthentication(completion: @escaping (Result<Bool, Error>) -> Void) {
        self.response = CreateSession(success: false, failure: nil, statusCode: nil, statusMessage: nil, sessionId: nil)
        
        guard let sessionId = UserDefaults.standard.string(forKey: "sessionId") else {
            fatalError("Session Id is not found")
        }
        
        let requestParameters = [
            "session_id": "\(sessionId)"
        ]
        
        print("Session ID: \(sessionId). HTTP Method: \(TmdbEndpoint.deleteSession.method)")
        
        NetworkEngine.request(
            endpoint: TmdbEndpoint.deleteSession,
            requestParameters: requestParameters) { [weak self] (result: Result<CreateSession, Error>) in
            guard let self else { return }
            switch result {
            case .success(let successfulResult):
                print(successfulResult)
                switch successfulResult.success {
                case true:
                    // successful result, deleted the session
                    self.response = CreateSession(success: false, failure: nil, statusCode: nil, statusMessage: nil, sessionId: nil)
                    UserDefaults.standard.removeObject(forKey: "sessionId")
                    completion(.success(true))
                case false:
                    // successful result, couldn't delete the session
                    guard let errorMessage = successfulResult.statusMessage else { return }
                    let error = NSError(domain: errorMessage, code: -1003)
                    print(errorMessage)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
