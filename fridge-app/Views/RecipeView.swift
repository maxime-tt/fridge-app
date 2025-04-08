import SwiftUI

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @State private var offset = CGSize.zero
    @State private var currentIndex = 0
    
    var body: some View {
        NavigationStack {
            if viewModel.generatedRecipes.isEmpty {
                VStack {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No recipes yet")
                        .font(.headline)
                    Text("Generate your first recipe from My Fridge")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            } else {
                ZStack {
                    ForEach(viewModel.generatedRecipes.indices.reversed(), id: \.self) { index in
                        if index >= currentIndex && index <= currentIndex + 2 {
                            RecipeCard(recipe: viewModel.generatedRecipes[index], viewModel: viewModel)
                                .offset(index == currentIndex ? offset : .zero)
                                .rotationEffect(.degrees(Double(offset.width) * 0.1))
                                .gesture(
                                    DragGesture()
                                        .onChanged { gesture in
                                            if index == currentIndex {
                                                offset = gesture.translation
                                            }
                                        }
                                        .onEnded { _ in
                                            withAnimation {
                                                if abs(offset.width) > 100 {
                                                    currentIndex += 1
                                                    if currentIndex >= viewModel.generatedRecipes.count {
                                                        currentIndex = 0
                                                    }
                                                }
                                                offset = .zero
                                            }
                                        }
                                )
                        }
                    }
                }
            }
        }
        .navigationTitle("Recipes (\(viewModel.generatedRecipes.count))")
    }
}

struct RecipeCard: View {
    let recipe: Recipe
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Recipe Header
                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.name)
                        .font(.title)
                        .bold()
                    
                    HStack {
                        Image(systemName: "clock")
                        Text(recipe.estimatedTime)
                        Spacer()
                        Image(systemName: "checklist")
                        Text("\(recipe.ingredients.count) ingredients")
                    }
                    .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                // Ingredients Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Ingredients")
                            .font(.headline)
                        Spacer()
                        Text("\(availableIngredients)/\(recipe.ingredients.count)")
                            .foregroundColor(availableIngredients == recipe.ingredients.count ? .green : .orange)
                            .font(.caption)
                    }
                    
                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 8))
                            Text(ingredient)
                            Spacer()
                            if viewModel.hasIngredient(ingredient) {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(.green)
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                            }
                        }
                        Divider()
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                
                // Instructions Section
                VStack(alignment: .leading, spacing: 10) {
                    Text("Instructions")
                        .font(.headline)
                    
                    ForEach(Array(recipe.instructions.enumerated()), id: \.element) { index, instruction in
                        HStack(alignment: .top) {
                            Text("\(index + 1).")
                                .font(.headline)
                                .foregroundColor(.accentColor)
                            Text(instruction)
                        }
                        if index < recipe.instructions.count - 1 {
                            Divider()
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
    
    private var availableIngredients: Int {
        recipe.ingredients.filter { viewModel.hasIngredient($0) }.count
    }
} 