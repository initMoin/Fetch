//
//  APIService.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import Foundation

class APIService {
   static let shared = APIService()
   
   private init() {}
   
   private let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
   
   func fetchRecipes() async throws -> [Recipe] {
      guard let url = URL(string: urlString) else {
         throw RecipeAPIError.invalidURL
      }
      
      do {
         let (data, response) = try await URLSession.shared.data(from: url)
         
         guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw RecipeAPIError.invalidResponse
         }
         
         let decoded = try JSONDecoder().decode(RecipeResponse.self, from: data)
         
         if decoded.recipes.isEmpty {
            throw RecipeAPIError.emptyData
         }
         
         return decoded.recipes
      } catch let decodingError as DecodingError {
         print("ERROR:  Decoding Error: \(decodingError)")
         throw RecipeAPIError.malformedData
      } catch {
         throw RecipeAPIError.requestFailed(error)
      }
   }
}
