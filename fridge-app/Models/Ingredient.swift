import Foundation

struct Ingredient: Identifiable, Hashable {
    let id = UUID()
    var name: String
    var quantity: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
} 