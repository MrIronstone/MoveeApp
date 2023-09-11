//
//  CreateSession.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 5.09.2023.
//

struct CreateSession: Decodable {
    let success: Bool
    let failure: Bool?
    let statusCode: String?
    let statusMessage: String?
    let sessionId: String?
}
