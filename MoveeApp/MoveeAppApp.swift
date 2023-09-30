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
    @StateObject private var persistentContainer = PersistentContainer.shared

    
    var body: some Scene {
        WindowGroup {
            if authentication.response.sessionId != nil {
                ContentView()
                    .environmentObject(authentication)
                    .environment(\.managedObjectContext, persistentContainer.container.viewContext)
            } else {
                LoginView()
                    .environmentObject(authentication)
                    .environment(\.managedObjectContext, persistentContainer.container.viewContext)
            }
        }
    }
}
