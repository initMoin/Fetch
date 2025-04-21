//
//  RecipeCallView.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import SwiftUI

struct RecipeCallView: View {
   let recipe: Recipe
   
   var body: some View {
      VStack(spacing: 20) {
         Text(recipe.name)
            .font(.title)
         
         if let youtubeURL = recipe.youtubeURL {
            Link("Watch on YouTube", destination: youtubeURL)
            // Only shows links if valid.
         }
         
         if let sourceURL = recipe.sourceURL {
            Link("View Original Source", destination: sourceURL)
         }
      }
      .padding()
      
//      Text("Recipe Call View Placeholder")
//         .font(.title)
//         .padding()
   }
}

#Preview {
   RecipeCallView(
      recipe: Recipe(
         id: UUID(),
         name: "Sample Recipe",
         cuisine: "Fusion",
         photoURLSmall: nil,
         photoURLLarge: nil,
         sourceURL: URL(string: "https://example.com"),
         youtubeURL: URL(string: "https://example.com")
      ))
}
