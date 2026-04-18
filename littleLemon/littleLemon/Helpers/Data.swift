import Foundation

struct MenuList: Codable {
    let items: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case items = "menu"
    }
}

struct MenuItem: Codable, Identifiable {
    let name: String
    let price: Double
    let category: String
    let desc: String
    let image: String
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case name = "name", price = "price", category="category", desc = "description", image = "image"
    }
}

