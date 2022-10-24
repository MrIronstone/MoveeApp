//
//  MoveeAppApp.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 23.10.2022.
//

import SwiftUI

@main
struct MoveeAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
