//
//  DataController.swift
//  SpacedOut
//
//  Created by Hanna Torales Palacios on 2025/02/15.
//

import CoreData

class DataController: ObservableObject {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Model")
        container.viewContext.automaticallyMergesChangesFromParent = true
        
        let groupID = "group.hanna.SpacedOut"
        if let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: groupID) {
            container.persistentStoreDescriptions.first?.url =
            url.appending(path: "Model.sqlite")
        }
        
        container.loadPersistentStores {_, error in
            if let error {
                fatalError("Fatal error loading store: \(error.localizedDescription)")
            }
        }
    }
}
