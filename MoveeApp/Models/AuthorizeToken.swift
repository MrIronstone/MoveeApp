//
//  AuthorizeToken.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 4.09.2023.
//

struct AuthorizeToken: Decodable {
    let success: Bool
    let statusCode: Int?
    let statusMessage: String?
    let expiresAt: String?
    let requestToken: String?
}
