//
//  APIServiceTests.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import SwiftUI
//@testable import FetchRecipes

@MainActor
struct APIServiceTestPreview: View {
   @State private var testResult: String = "Running tests..."
   
   var body: some View {
       ScrollView {
           Text(testResult)
               .font(.body)
               .padding()
       }
       .task {
           await runTests()
       }
   }

   func runTests() async {
       var output = ""

       do {
           let json = """
           {
               "recipes": [
                   {
                       "uuid": "11111111-2222-3333-4444-555555555555",
                       "name": "Test Recipe",
                       "cuisine": "Test Cuisine",
                       "photo_url_small": "https://example.com/small.jpg",
                       "photo_url_large": "https://example.com/large.jpg"
                   }
               ]
           }
           """
             .data(using: .utf8)!

           let decoded = try JSONDecoder().decode(RecipeResponse.self, from: json)
           assert(decoded.recipes.count == 1, "Expected 1 recipe")
           assert(decoded.recipes.first?.name == "Test Recipe", "Expected recipe name to be 'Test Recipe'")
           output += "✅ testValidRecipeDecoding passed\n"
       } catch {
           output += "❌ testValidRecipeDecoding failed: \(error)\n"
       }

       do {
           let json = """
           {
               "recipes": [
                   {
                       "uuid": 12345,
                       "name": "Bad Data"
                   }
               ]
           }
           """.data(using: .utf8)!

           _ = try JSONDecoder().decode(RecipeResponse.self, from: json)
           output += "❌ testMalformedDataThrowsError failed: should not decode\n"
       } catch {
           output += "✅ testMalformedDataThrowsError passed\n"
       }

       do {
           let json = """
           {
               "recipes": []
           }
           """.data(using: .utf8)!

           let decoded = try JSONDecoder().decode(RecipeResponse.self, from: json)
           assert(decoded.recipes.isEmpty, "Expected empty recipe list")
           output += "✅ testEmptyRecipeListParsesSuccessfully passed\n"
       } catch {
           output += "❌ testEmptyRecipeListParsesSuccessfully failed: \(error)\n"
       }

       testResult = output
   }
}

#Preview {
    APIServiceTestPreview()
}
