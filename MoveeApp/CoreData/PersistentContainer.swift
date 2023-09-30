//
//  PersistenContainer.swift
//  MoveeApp
//
//  Created by Demirtas, Husamettin on 16.09.2023.
//

import Foundation
import CoreData

class PersistentContainer: ObservableObject {
    @Published var container = NSPersistentContainer(name: "FavoriteList")
    
    static let shared = PersistentContainer()
    
    private init() {
        container.loadPersistentStores { _, error in
            if let error {
                print("Error while loading the persistent container. \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved..")
        } catch {
            print("Error while saving persistent container. \(error.localizedDescription)")
        }
    }
    
    func addTitle(title: Title) {
        let titleEntity = TitleEntity(context: self.container.viewContext)
        titleEntity.id = Int64(title.id)
        titleEntity.title = title.title
        titleEntity.name = title.name
        titleEntity.overview = title.overview
        if checkIfTitleExistInCoreData(id: title.id) {
            print("Already existed title!. Didn't add the \(title.title ?? title.name ?? "N/A")")
        } else {
            save(context: self.container.viewContext)
        }
    }
    
    func removeTitle(title: Title) {
        let managedContext = container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TitleEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", title.id)

        do {
            let result = try managedContext.fetch(fetchRequest).first
            guard let result else { return }
            managedContext.delete(result)
            print("Successfully removed item from core data. Id: \(title.id), title: \(title.title ?? title.name ?? "N/A")")
        } catch {
            print("Could not fetch. \(error)")
        }
    }
    
    func checkIfTitleExistInCoreData(id: Int) -> Bool {
        let managedContext = container.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "TitleEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "id == %d", id)

        do {
            let results = try managedContext.fetch(fetchRequest)
            if !results.isEmpty {
                return true
            } else {
                return false
            }
        } catch {
            print("Could not fetch. \(error)")
            return false
        }
    }
    
    func clearAllData() {
        // Get a reference to a NSPersistentStoreCoordinator
        let storeContainer = container.persistentStoreCoordinator

        // Delete each existing persistent store
        for store in storeContainer.persistentStores {
            do {
                guard let url = store.url else { return }
                try storeContainer.destroyPersistentStore(
                    at: url,
                    ofType: store.type,
                    options: nil
                )
            } catch {
                print("Error while clearing all data of CoreData. \(error.localizedDescription)")
            }
        }

        // Re-create the persistent container
        container = NSPersistentContainer(
            name: "FavoriteList" // the name of a .xcdatamodeld file
        )

        // Calling loadPersistentStores will re-create the
        // persistent stores
        container.loadPersistentStores { _, error in
            if let error {
                print("Error while loading persisten store \(error.localizedDescription)")
            }
        }
    }
}
