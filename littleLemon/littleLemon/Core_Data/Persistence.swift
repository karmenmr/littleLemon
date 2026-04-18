internal import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    @MainActor
    static let preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let dish = Dish(context: viewContext)
        dish.name = "Sample Dish 1"
        dish.price = 10.99
        dish.desc = "A description of a dish"
        dish.image = "littlelemon-hero"
        
        let dish2 = Dish(context:viewContext)
        dish2.name = "Sample Dish 2"
        dish2.price = 8.99
        dish2.desc = "A description of a dish2"
        dish2.image = "littlelemon-hero"
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "littleLemon")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
