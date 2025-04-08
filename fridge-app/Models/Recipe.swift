import Foundation

struct Recipe: Identifiable, Equatable {
    let id = UUID()
    var name: String
    var ingredients: [String]
    var instructions: [String]
    var estimatedTime: String
    
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        // Compare all fields except id to determine if recipes are identical
        return lhs.name == rhs.name &&
            lhs.ingredients == rhs.ingredients &&
            lhs.instructions == rhs.instructions &&
            lhs.estimatedTime == rhs.estimatedTime
    }
} 