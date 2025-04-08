import SwiftUI

struct CategoryCard: View {
    let category: IngredientCategory
    let onSelect: (String) -> Void
    
    var body: some View {
        VStack {
            Image(systemName: category.systemImage)
                .font(.title)
                .foregroundColor(.accentColor)
            Text(category.name)
                .font(.caption)
        }
        .frame(width: 80, height: 80)
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .onTapGesture {
            if let randomIngredient = category.ingredients.randomElement() {
                onSelect(randomIngredient)
            }
        }
    }
} 