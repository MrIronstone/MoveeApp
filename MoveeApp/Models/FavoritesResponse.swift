//
//  FavoritesResponse.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 15.09.2023.
//

struct FavoritesResponse: Decodable {
    let page: Int?
    let results: [Title]?
    let totalPages: Int?
    let totalResults: Int?
}
