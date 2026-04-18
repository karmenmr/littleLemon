import Foundation
internal import CoreData
import Combine

class CoreDataLayer {
    
    /// Converts MenuItem to Dish Core Data object and saves in database
    /// Before all empties the database
    /// Function checks for duplicates before entring to prevent data duplication
    static func createData(from items: [MenuItem], in viewContext: NSManagedObjectContext) {
        guard !items.isEmpty else { return }
        
        Self.deleteAll(in: viewContext)
        let cancellable = items.publisher
            .compactMap { item -> Dish? in
                if Self.exists(name: item.name, viewContext) != nil { return nil }
                
                let dish = Dish(context: viewContext)
                dish.name = item.name
                dish.price = item.price
                dish.category = item.category
                dish.desc = item.desc
                dish.image = item.image
                return dish
            }
            .sink { _ in }
        
        defer { cancellable.cancel() }
        
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch {
            print("\(#function): \(#line): \(error.localizedDescription)")
        }
    }
    
    @discardableResult
    fileprivate static func exists(name: String, _ context: NSManagedObjectContext) -> Dish? {
        let request = request()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let results = try context.fetch(request)
            if results.count > 0 { return results.first }
        } catch {
            print("\(#function): \(#line): \(error.localizedDescription)")
        }
        return nil
    }
    
    static func request() -> NSFetchRequest<Dish> {
        let request = NSFetchRequest<Dish>(entityName: "Dish")
        request.returnsDistinctResults = true
        request.returnsDistinctResults = true
        return request
    }
    
    fileprivate static func deleteAll(in viewContext: NSManagedObjectContext) {
        let request = NSBatchDeleteRequest(fetchRequest: request() as! NSFetchRequest<NSFetchRequestResult>)
        request.resultType = .resultTypeObjectIDs
        
        do {
            let deleteResult = try viewContext.execute(request) as? NSBatchDeleteResult
            
            // Extract the IDs of the deleted managed objectss from the request's result.
            if let objectIDs = deleteResult?.result as? [NSManagedObjectID] {
                NSManagedObjectContext.mergeChanges(
                    fromRemoteContextSave: [NSDeletedObjectsKey: objectIDs],
                    into: [viewContext]
                )
            }
        } catch {
            print("\(#function): \(#line): \(error.localizedDescription)")
        }
        
        
    }
}
