//
//  Credits.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 4.08.2023.
//

struct CreditsResponse: Decodable, Identifiable, Hashable {
    let id: Int
    let cast: [Person]
    let crew: [Person]
}

struct PersonCreditsResponse: Decodable, Identifiable, Hashable {
    let id: Int
    let cast: [Title]
    let crew: [Title]
}
