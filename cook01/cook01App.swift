//
//  cook01App.swift
//  cook01
//
//  Created by 云 on 2025/11/10.
//

import SwiftUI
import CoreData

@main
struct cook01App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
