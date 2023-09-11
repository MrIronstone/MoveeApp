//
//  CreateToken.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 3.09.2023.
//

struct CreateToken: Decodable {
    let success: Bool
    let expiresAt: String
    let requestToken: String
}
