//
//  RecipeListViewModel.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import Foundation
import Observation

@Observable
class RecipeListViewModel {
   var recipes: [Recipe] = []
   var isLoading: Bool = false
   var errorMessage: String?
   
   func loadRecipes() async {
      isLoading = true
      errorMessage = nil
      
      do {
         let fetchedRecipes = try await APIService.shared.fetchRecipes()
         self.recipes = fetchedRecipes
      } catch {
         if error is RecipeAPIError {
            self.errorMessage = error.localizedDescription
         } else {
            self.errorMessage = "An unexpected error occurred."
         }
      }
      
      isLoading = false
   }
}

