import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: "refrigerator")
                .font(.system(size: 50))
                .foregroundColor(.gray)
            Text("Your fridge is empty")
                .font(.headline)
            Text("Add ingredients to get started")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
} 