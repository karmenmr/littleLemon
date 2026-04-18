import Foundation
internal import CoreData
import SwiftUI

struct FetchedObjects<T, Content: View>: View where T: NSManagedObject {
    let content: ([T]) -> Content
    let request: FetchRequest<T>
    
    var body: some View {
        content(request.wrappedValue.map(\.self))
    }
    
    init(
        predicate: NSPredicate = NSPredicate(value: true),
        sortDescriptors: [NSSortDescriptor] = [],
        @ViewBuilder content: @escaping ([T]) -> Content
    ) {
        self.content = content
        self.request = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: predicate)
    }
}
