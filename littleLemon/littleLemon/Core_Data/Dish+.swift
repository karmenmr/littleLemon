import Foundation
internal import CoreData

extension Dish {
    var nameValue: String { self.name ?? "Unknown" }
    var priceValue: String { String(format: "$%.2f", self.price) }
    var descValue: String { self.desc ?? "No description." }
    var imageValue: String { self.image ?? "littlelemon-hero" }
}

extension Dish {
    private static func request() -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: Self.self))
        request.returnsDistinctResults = true
        request.returnsDistinctResults = true
        return request
    }
}

