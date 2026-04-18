import SwiftUI
internal import CoreData

@main
struct littleLemonApp: App {
    let persistenceController = PersistenceController.shared
  
    var body: some Scene {
        WindowGroup {
            Home()
                .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
        }
    }
}
