//
//  ProfileViewModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 7.09.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var accountDetails: AccountDetails?
    
    init() {
        getAccountDetails()
    }
    
    public func getAccountDetails() {
        guard let sessionId = UserDefaults.standard.string(forKey: "sessionId") else { return }
        NetworkEngine.request(endpoint: TmdbEndpoint.accountDetail(sessionId: sessionId)) { [weak self] (result: Result<AccountDetails, Error>) in
            guard let self else { return }
            switch result {
            case .success(let success):
                self.accountDetails = success
                guard let username = success.username else { return }
                UserDefaults.standard.set(success.id, forKey: "accountId")
                print(username)
                FavoriteList.shared.getFavorites()
                FavoriteList.shared.getRatedTitles()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
