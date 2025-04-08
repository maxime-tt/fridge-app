import SwiftUI

struct AddIngredientView: View {
    @Binding var ingredientName: String
    @Binding var quantity: String
    @Binding var isPresented: Bool
    @State private var textQuantity: String = "1"
    @State private var unit: String = "piece"
    let onSave: () -> Void
    
    let units = ["piece", "gram", "ml", "cup", "tbsp"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Ingredient Name", text: $ingredientName)
                
                Section("Quantity") {
                    HStack(spacing: 15) {
                        TextField("Amount", text: $textQuantity)
                            .keyboardType(.decimalPad)
                            .frame(maxWidth: 100)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: textQuantity) { newValue in
                                // Only allow numbers and decimal point
                                let filtered = newValue.filter { "0123456789.".contains($0) }
                                if filtered != newValue {
                                    textQuantity = filtered
                                }
                                updateQuantity()
                            }
                        
                        Picker("Unit", selection: $unit) {
                            ForEach(units, id: \.self) { unit in
                                Text(unit).tag(unit)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .onChange(of: unit) { _ in
                            updateQuantity()
                        }
                    }
                }
            }
            .onAppear {
                // Initialize with default values
                textQuantity = "1"
                updateQuantity()
            }
            .navigationTitle("Add Ingredient")
            .navigationBarItems(
                leading: Button("Cancel") {
                    isPresented = false
                },
                trailing: Button("Save") {
                    onSave()
                    isPresented = false
                }
                .disabled(ingredientName.isEmpty || textQuantity.isEmpty)
            )
        }
    }
    
    private func updateQuantity() {
        if !textQuantity.isEmpty {
            // Format the number to remove trailing zeros
            if let value = Double(textQuantity) {
                let formatted = String(format: "%.1f", value)
                    .replacingOccurrences(of: ".0", with: "")
                quantity = "\(formatted) \(unit)"
            }
        }
    }
} 