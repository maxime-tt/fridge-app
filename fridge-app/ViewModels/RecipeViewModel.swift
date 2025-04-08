import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var ingredients: [Ingredient] = []
    @Published var generatedRecipe: Recipe?
    @Published var isLoading = false
    @Published var error: String?
    @Published var selectedTab = 0
    @Published var generatedRecipes: [Recipe] = []
    
    private let openAIService = OpenAIService()
    
    func addIngredient(name: String, quantity: String) {
        let ingredient = Ingredient(name: name, quantity: quantity)
        ingredients.append(ingredient)
    }
    
    func removeIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    func generateRecipe() async {
        guard !ingredients.isEmpty else {
            error = "Please add some ingredients first"
            return
        }
        
        isLoading = true
        do {
            let recipe = try await openAIService.generateRecipe(from: ingredients)
            
            // Check if this exact recipe already exists
            if generatedRecipes.contains(recipe) {
                error = "This recipe has already been generated. Try again for a different recipe."
                isLoading = false
                return
            }
            
            generatedRecipe = recipe
            generatedRecipes.append(recipe)
            selectedTab = 1 // Switch to recipe tab
        } catch {
            self.error = error.localizedDescription
        }
        isLoading = false
    }
    
    func hasIngredient(_ recipeIngredient: String) -> Bool {
        // Convert both strings to lowercase for case-insensitive comparison
        let normalizedRecipeIngredient = recipeIngredient.lowercased()
        
        return ingredients.contains { ingredient in
            // Check if the recipe ingredient contains or is contained in the fridge ingredient
            let normalizedFridgeIngredient = ingredient.name.lowercased()
            return normalizedRecipeIngredient.contains(normalizedFridgeIngredient) ||
                   normalizedFridgeIngredient.contains(normalizedRecipeIngredient)
        }
    }
} 