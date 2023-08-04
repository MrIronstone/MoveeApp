//
//  Credits.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 4.08.2023.
//

struct CreditsResponse: Decodable, Identifiable, Hashable {
    let id: Int
    let cast: [Person?]?
    let crew: [Person?]?
}

struct Person: Codable, Identifiable, Hashable {
    let id: Int
    let creditId: String?
    let name: String?
    let originalName: String?
    let profilePath: String?
    let knownForDepartment: String?
    let popularity: Double?
    let castId: Int?
    let character: String?
    let order: Int?
    let department: String?
    let job: String?
}
