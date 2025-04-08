import Foundation

struct IngredientCategory: Identifiable {
    let id = UUID()
    let name: String
    let systemImage: String
    let ingredients: [String]
}

extension IngredientCategory {
    static let categories = [
        IngredientCategory(name: "Proteins", systemImage: "fish", ingredients: [
            "Chicken Breast", "Ground Beef", "Salmon", "Eggs", "Tofu", "Shrimp", "Pork Chops",
            "Turkey", "Tuna", "Lamb", "Duck", "Bacon", "Ham", "Sausage", "Crab"
        ]),
        IngredientCategory(name: "Vegetables", systemImage: "leaf", ingredients: [
            "Tomato", "Onion", "Carrot", "Potato", "Broccoli", "Spinach", "Bell Pepper",
            "Cucumber", "Lettuce", "Zucchini", "Mushroom", "Corn", "Asparagus", "Green Beans",
            "Cauliflower", "Eggplant", "Celery", "Peas", "Sweet Potato", "Cabbage"
        ]),
        IngredientCategory(name: "Dairy", systemImage: "cup.and.saucer", ingredients: ["Milk", "Cheese", "Yogurt", "Butter", "Cream"]),
        IngredientCategory(name: "Grains", systemImage: "wheat", ingredients: ["Rice", "Pasta", "Bread", "Flour", "Oats"]),
        IngredientCategory(name: "Spices", systemImage: "sparkles", ingredients: ["Salt", "Pepper", "Garlic", "Basil", "Oregano"])
    ]
    
    static let itemIcons: [String: String] = [
        "Chicken Breast": "bird",
        "Ground Beef": "cow",
        "Salmon": "fish",
        "Eggs": "egg",
        "Tofu": "square.fill",
        "Tomato": "circle.fill",
        "Onion": "circle.circle",
        "Carrot": "leaf.fill",
        // Add more mappings...
    ]
} 