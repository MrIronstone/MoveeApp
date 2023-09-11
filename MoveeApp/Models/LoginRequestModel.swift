//
//  LoginRequestModel.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 3.09.2023.
//

struct LoginRequestModel: Encodable {
    let username: String
    let password: String
    let requestToken: String
}
