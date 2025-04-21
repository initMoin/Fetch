//
//  ImageLoader.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import Foundation
import UIKit

actor ImageLoader {
   static let shared = ImageLoader()
   
   func loadImage(from url: URL) async -> UIImage? {
      let key = await ImageCache.shared.key(for: url)
      
      if let cached = await ImageCache.shared.image(forKey: key) {
         return cached
      }
      
      do {
         let (data, _) = try await URLSession.shared.data(from: url)
         if let image = UIImage(data: data) {
            await ImageCache.shared.saveImage(image, forKey: key)
            return image
         }
      } catch {
         print("Image loading error: \(error)")
      }
      
      // TODO: Add retry logic for unreliable networks ...in the future.
      
      return nil
   }
}
