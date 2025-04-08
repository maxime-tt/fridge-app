import SwiftUI

struct IngredientCard: View {
    let ingredient: Ingredient
    let onDelete: () -> Void
    let onEdit: () -> Void
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let iconName = IngredientCategory.itemIcons[ingredient.name] {
                    Image(systemName: iconName)
                        .foregroundColor(.accentColor)
                }
                Text(ingredient.name)
                    .font(.headline)
                Spacer()
                Menu {
                    Button(action: onEdit) {
                        Label("Edit", systemImage: "pencil")
                    }
                    Button(role: .destructive, action: onDelete) {
                        Label("Delete", systemImage: "trash")
                    }
                } label: {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
            Text(ingredient.quantity)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
} 