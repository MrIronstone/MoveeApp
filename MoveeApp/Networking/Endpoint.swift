//
//  Endpoint.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 26.10.2022.
//

import Foundation

protocol Endpoint {
    // HTTP or HTTPS
    var scheme: String { get }
    
    // Example: " api.flickr.com
    var baseURL: String { get }
    
    // Example: "/services/rest/"
    var path: String { get }
    
    // [URLQueryItem(name: "api_key, value: API_KEY)]
    var parameters: [URLQueryItem] { get }
    
    // "GET"
    var method: String { get }    
}
