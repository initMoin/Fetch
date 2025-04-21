//
//  RecipeListView.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import SwiftUI

struct RecipeListView: View {
   @State var viewModel = RecipeListViewModel()
   
   var body: some View {
      NavigationStack {
         Group {
            if viewModel.isLoading {
               ProgressView("Loading recipes...") // Display loading indicator while fetching recipes
            } else if let errorMessage = viewModel.errorMessage {
               VStack(spacing: 16) {
                  Image(systemName: "exclamationmark.triangle")
                     .font(.system(size: 40))
                     .foregroundStyle(.orange)
                  Text("Error")
                     .font(.title2)
                     .bold()
                  Text(errorMessage)
                     .multilineTextAlignment(.center)
                     .foregroundStyle(.secondary)
               }
               .padding()
               .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.recipes.isEmpty {
               VStack(spacing: 16) {
                  Image(systemName: "text.magnifyingglass")
                     .font(.system(size: 40))
                     .foregroundStyle(.gray)
                  Text("No Recipes Available")
                     .font(.title3)
                     .bold()
               }
               .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
               List(viewModel.recipes) { recipe in
                  VStack(spacing: 0) {
                     HStack(spacing: 16) {
                        RecipeImageView(url: recipe.photoURLSmall)
                           .frame(width: 60, height: 60)
                           .clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        VStack(alignment: .leading, spacing: 4) {
                           Text(recipe.name)
                              .font(.headline)
                              .fontWeight(.semibold)
                           Text(recipe.cuisine)
                              .font(.subheadline)
                              .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                     }
                     .padding(.vertical, 8)
                  }
               }
               .listStyle(.plain)
               .refreshable {
                  await viewModel.loadRecipes()
               }
            }
         }
         .navigationTitle("Recipes")
         .task {
            await viewModel.loadRecipes()
         }
      }
   }
}

#Preview {
   RecipeListView()
}
