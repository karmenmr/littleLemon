import Foundation
import SwiftUI
import Combine
internal import CoreData

@MainActor
class DishModel: ObservableObject {
    static var shared: DishModel = .init(PersistenceController.shared.container.viewContext)
    
    let viewContext: NSManagedObjectContext
    
    @Published var dishes: [Dish] = []
    @Published var categories: [String] = []
    
    @Published var searchText: String = "" {
        didSet {
            createFetchRequest(viewContext, isSearchUpdate: true)
        }
    }
    
    var selectedCategory: String? = nil {
        didSet {
            createFetchRequest(viewContext, isSearchUpdate: true)
        }
    }
    
    private let dataService = MenuDataService()
    
    private init(_ viewContext: NSManagedObjectContext, isPreview: Bool = false) {
        self.viewContext = viewContext
        
        if isPreview {
            createFetchRequest(viewContext, isSearchUpdate: false)
        } else {
            addSubscribers(viewContext)
        }
    }
}

extension DishModel {
    private func addSubscribers(_ viewContext: NSManagedObjectContext) {
        var cancellable: AnyCancellable?
        cancellable = dataService.$items
            .sink(receiveCompletion: { completion in
                cancellable?.cancel()
            }, receiveValue: { [weak self]
                (items: [MenuItem]) in
                if !items.isEmpty {
                    CoreDataLayer.createData(from: items, in: viewContext)
                    self?.createFetchRequest(viewContext, isSearchUpdate: false)
                }
            })
    }
    
    private func createFetchRequest(_ viewContext: NSManagedObjectContext, isSearchUpdate: Bool) {
        let request = CoreDataLayer.request()
        let categoryPredicate = (selectedCategory != nil) ? NSPredicate(format: "category == %@", selectedCategory!.lowercased()) : nil
        let searchPredicate = !searchText.isEmpty ? NSPredicate(format: "name CONTAINS[cd] %@", searchText) : nil
        
        switch (categoryPredicate, searchPredicate) {
        case let (predicate1, predicate2) where predicate1 != nil && predicate2 != nil:
            request.predicate = NSCompoundPredicate(type: .and, subpredicates: [predicate1!, predicate2!])
        case let (predicate1, nil) where predicate1 != nil :
            request.predicate = predicate1!
        case let (nil, predicate2) where predicate2 != nil:
            request.predicate = predicate2!
        default:
            request.predicate = NSPredicate(format: "TRUEPREDICATE")
        }
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true, selector: #selector(NSString.localizedStandardCompare))]
        
        do {
            dishes = try viewContext.fetch(request)
            print(dishes.count)
            guard !isSearchUpdate else { return }
            
            var arr = Set<String>()
            var cancellable: AnyCancellable?
            cancellable = dishes.publisher
                .compactMap{ $0.category }
                .removeDuplicates()
                .sink(receiveCompletion: {[weak self] completion in
                    if completion == .finished {
                        let predefined = ["Starters", "Mains", "Desserts", "Drinks"]
                        
                        self?.categories.removeAll()
                        for c in predefined {
                            if let category = arr.first(where: {$0 == c}) {
                                self?.categories.append(category)
                                arr.remove(category)
                            }
                        }
                        if arr.count > 0 {
                            self?.categories.append(contentsOf: arr)
                        }
                    }
                    cancellable?.cancel()
                }, receiveValue: { category in
                    arr.insert(category.capitalized)
                })
            
        } catch {
            print("\(#function): \(#line): \(error.localizedDescription)")
        }
    }
}

extension DishModel {
    static var preview: DishModel = {
        let model = DishModel(PersistenceController.preview.container.viewContext, isPreview: true)
        
        model.categories = ["Starters", "Mains", "Desserts", "Drinks"]
        return model
    }()
}

