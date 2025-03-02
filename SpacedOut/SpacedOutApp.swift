//
//  SpacedOutApp.swift
//  SpacedOut
//
//  Created by Hanna Torales Palacios on 2025/02/15.
//

import SwiftUI

@main
struct SpacedOutApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
