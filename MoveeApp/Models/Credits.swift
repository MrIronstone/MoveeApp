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

struct SearchResponse: Decodable {
    let page: Int
    let results: [Content]?
    let totalPages: Int
    let totalResults: Int
}

enum Content: Hashable {
    case title(Title)
    case person(Person)
}

extension Content: Decodable {
    private enum CodingKeys: String, CodingKey {
        case mediaType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let singleContainer = try decoder.singleValueContainer()
        
        let type = try container.decode(String.self, forKey: .mediaType)
        switch type {
        case "movie", "tv":
            let title = try singleContainer.decode(Title.self)
            self = .title(title)
        case "person":
            let person = try singleContainer.decode(Person.self)
            self = .person(person)
        default:
            fatalError("Unknown type of content.")
            // or handle this case properly
        }
    }
}
