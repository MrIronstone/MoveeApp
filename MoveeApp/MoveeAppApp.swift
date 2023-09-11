//
//  MoveeAppApp.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 23.10.2022.
//

import SwiftUI

@main
struct MoveeAppApp: App {
    @StateObject var authentication = Authentication()
    
    var body: some Scene {
        WindowGroup {
            if authentication.response.sessionId != nil {
                ContentView()
                    .environmentObject(authentication)
            } else {
                LoginView()
                    .environmentObject(authentication)
            }
        }
    }
}
