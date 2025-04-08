import SwiftUI

struct FridgeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Binding var showingAddIngredient: Bool
    @Binding var newIngredientName: String
    @Binding var newIngredientQuantity: String
    @Binding var editingIngredient: Ingredient?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    QuickAddSection(viewModel: viewModel)
                    IngredientsSection(
                        viewModel: viewModel,
                        showingAddIngredient: $showingAddIngredient,
                        newIngredientName: $newIngredientName,
                        newIngredientQuantity: $newIngredientQuantity,
                        editingIngredient: $editingIngredient
                    )
                    
                    // Generate Recipe Button
                    Button(action: {
                        Task {
                            await viewModel.generateRecipe()
                        }
                    }) {
                        HStack {
                            Image(systemName: "wand.and.stars")
                            Text("Generate Recipe")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .disabled(viewModel.ingredients.isEmpty || viewModel.isLoading)
                    .opacity(viewModel.ingredients.isEmpty ? 0.5 : 1.0)
                }
                .padding(.vertical)
            }
            .navigationTitle("My Fridge")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        editingIngredient = nil
                        newIngredientName = ""
                        newIngredientQuantity = ""
                        showingAddIngredient = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.accentColor)
                    }
                }
            }
        }
    }
}

private struct QuickAddSection: View {
    let viewModel: RecipeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Quick Add")
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(IngredientCategory.categories) { category in
                        CategoryCard(category: category) { ingredient in
                            viewModel.addIngredient(name: ingredient, quantity: "1")
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

private struct IngredientsSection: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Binding var showingAddIngredient: Bool
    @Binding var newIngredientName: String
    @Binding var newIngredientQuantity: String
    @Binding var editingIngredient: Ingredient?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("My Ingredients")
                    .font(.headline)
                Spacer()
                Text("\(viewModel.ingredients.count) items")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            
            if viewModel.ingredients.isEmpty {
                EmptyStateView()
            } else {
                LazyVGrid(columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ], spacing: 15) {
                    ForEach(viewModel.ingredients) { ingredient in
                        IngredientCard(
                            ingredient: ingredient,
                            onDelete: {
                                if let index = viewModel.ingredients.firstIndex(where: { $0.id == ingredient.id }) {
                                    viewModel.removeIngredient(at: IndexSet(integer: index))
                                }
                            },
                            onEdit: {
                                editingIngredient = ingredient
                                newIngredientName = ingredient.name
                                newIngredientQuantity = ingredient.quantity
                                showingAddIngredient = true
                            }
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
} 