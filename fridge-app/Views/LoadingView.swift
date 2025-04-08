import SwiftUI

struct LoadingView: View {
    @State private var isOpen = false
    
    var body: some View {
        VStack {
            Image(systemName: "refrigerator")
                .font(.system(size: 100))
                .rotationEffect(.degrees(isOpen ? 30 : 0))
                .animation(Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: isOpen)
            
            Text("Generating Recipe...")
                .font(.headline)
                .padding(.top)
        }
        .onAppear {
            isOpen = true
        }
    }
} 