import Foundation

class OpenAIService {
    private let apiKey = Config.openAIKey
    private let baseURL = "https://api.openai.com/v1/chat/completions"
    
    struct OpenAIResponse: Codable {
        let choices: [Choice]
        
        struct Choice: Codable {
            let message: Message
        }
        
        struct Message: Codable {
            let content: String
        }
    }
    
    struct RecipeResponse: Codable {
        let name: String
        let ingredients: [String]
        let instructions: [String]
        let estimatedTime: String
    }
    
    func generateRecipe(from ingredients: [Ingredient]) async throws -> Recipe {
        let ingredientsList = ingredients.map { "\($0.name) (\($0.quantity))" }.joined(separator: ", ")
        
        let prompt = """
        Generate a recipe using some or all of these ingredients: \(ingredientsList).
        Format the response as JSON with the following structure:
        {
            "name": "Recipe Name",
            "ingredients": ["ingredient 1", "ingredient 2"],
            "instructions": ["step 1", "step 2"],
            "estimatedTime": "30 minutes"
        }
        Only respond with the JSON, no other text.
        """
        
        var request = URLRequest(url: URL(string: baseURL)!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": [
                ["role": "user", "content": prompt]
            ],
            "temperature": 0.7
        ]
        
        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response type"])
        }
        
        if httpResponse.statusCode != 200 {
            if let errorJson = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
               let error = errorJson["error"] as? [String: Any],
               let message = error["message"] as? String {
                throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: message])
            }
            throw NSError(domain: "", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: "Failed with status code: \(httpResponse.statusCode)"])
        }
        
        let openAIResponse = try JSONDecoder().decode(OpenAIResponse.self, from: data)
        guard let content = openAIResponse.choices.first?.message.content,
              let jsonData = content.data(using: .utf8) else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid response format"])
        }
        
        print("OpenAI Response Content: \(content)") // Debug print
        
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: jsonData)
        
        return Recipe(
            name: recipeResponse.name,
            ingredients: recipeResponse.ingredients,
            instructions: recipeResponse.instructions,
            estimatedTime: recipeResponse.estimatedTime
        )
    }
} 
