//
//  RecipeImageView.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import SwiftUI
import UIKit

@Observable
class RecipeImageModel {
   var image: UIImage?
   var isLoading = false
   
   func load(url: URL?) async {
      guard let url, image == nil else { return }
      isLoading = true
      
      image = await ImageLoader.shared.loadImage(from: url)
      isLoading = false
   }
}

struct RecipeImageView: View {
   let url: URL?
   
   @State var model = RecipeImageModel()
   
   var body: some View {
      // Show gray placeholder until image loads.
      ZStack {
         if let image = model.image {
            Image(uiImage: image)
               .resizable()
               .scaledToFill()
         } else if model.isLoading {
            ProgressView()
         } else {
            RoundedRectangle(cornerRadius: 8)
               .fill(Color.gray.opacity(0.3))
         }
      }
      .clipShape(RoundedRectangle(cornerRadius: 8))
      .contentShape(RoundedRectangle(cornerRadius: 8))
      .task {
         await model.load(url: url)
      }
   }
}
