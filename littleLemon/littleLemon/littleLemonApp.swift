//
//  littleLemonApp.swift
//  littleLemon
//
//  Created by Karmen Mirzoyan on 4/9/26.
//

import SwiftUI
import CoreData

@main
struct littleLemonApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
