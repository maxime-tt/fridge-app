//
//  ContentView.swift
//  fridge-app
//
//  Created by Mako Kapanadze on 21.01.25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    @State private var showingAddIngredient = false
    @State private var newIngredientName = ""
    @State private var newIngredientQuantity = ""
    @State private var selectedTab = 0
    @State private var editingIngredient: Ingredient?

    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                // My Fridge Tab
                FridgeView(
                    viewModel: viewModel,
                    showingAddIngredient: $showingAddIngredient,
                    newIngredientName: $newIngredientName,
                    newIngredientQuantity: $newIngredientQuantity,
                    editingIngredient: $editingIngredient
                )
                .tabItem {
                    Label("My Fridge", systemImage: "refrigerator")
                }
                .tag(0)

                // Recipe Tab
                RecipeView(viewModel: viewModel)
                    .tabItem {
                        Label("Recipes (\(viewModel.generatedRecipes.count))", systemImage: "fork.knife")
                    }
                    .tag(1)
            }

            if viewModel.isLoading {
                LoadingView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(.systemBackground))
            }
        }
        .sheet(isPresented: $showingAddIngredient) {
            AddIngredientView(
                ingredientName: $newIngredientName,
                quantity: $newIngredientQuantity,
                isPresented: $showingAddIngredient,
                onSave: {
                    if let editing = editingIngredient,
                       let index = viewModel.ingredients.firstIndex(where: { $0.id == editing.id })
                    {
                        viewModel.ingredients[index] = Ingredient(name: newIngredientName, quantity: newIngredientQuantity)
                    } else {
                        viewModel.addIngredient(name: newIngredientName, quantity: newIngredientQuantity)
                    }
                    newIngredientName = ""
                    newIngredientQuantity = ""
                    editingIngredient = nil
                }
            )
        }
        .alert("Error", isPresented: .init(
            get: { viewModel.error != nil },
            set: { if !$0 { viewModel.error = nil } }
        )) {
            Text(viewModel.error ?? "Unknown error")
        }
        .onAppear(perform: {
            for family: String in UIFont.familyNames {
                print(family)
                for names: String in UIFont.fontNames(forFamilyName: family) {
                    print("== \(names)")
                }
            }
        }
        )
    }
}

#Preview {
    ContentView()
}
