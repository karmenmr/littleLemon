//
//  somethingApp.swift
//  something
//
//  Created by Karmen Mirzoyan on 4/18/26.
//

import SwiftUI
import CoreData

@main
struct somethingApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
