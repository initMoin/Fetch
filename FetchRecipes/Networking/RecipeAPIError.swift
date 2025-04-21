//
//  APIError.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import Foundation

enum RecipeAPIError: Error, LocalizedError {
   case invalidURL
   case requestFailed(Error)
   case invalidResponse
   case malformedData
   case emptyData
   
   var errorDescription: String? { // Helps show clearer error messages in UI
      switch self {
      case .invalidURL:
         return "The URL provided was invalid."
      case .requestFailed(let error):
         return "Network request failed: \(error.localizedDescription)"
      case .invalidResponse:
         return "The server response was invalid."
      case .malformedData:
         return "Data is malformed or could not be decoded."
      case .emptyData:
         return "No recipes available."
      }
   }
}
