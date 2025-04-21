//
//  ImageCache.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import Foundation
import UIKit

final actor ImageCache {
   static let shared = ImageCache()
   
   private let cacheDirectory: URL
   
   private init() {
      let manager = FileManager.default
      if let cache = manager.urls(for: .cachesDirectory, in: .userDomainMask).first {
         self.cacheDirectory = cache.appendingPathComponent("RecipeImages", isDirectory: true)
         try? manager.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
      } else {
         fatalError("Unable to find cache directory.")
      }
   }
   
   func image(forKey key: String) async -> UIImage? {
      let url = cacheDirectory.appendingPathComponent(key)
      guard FileManager.default.fileExists(atPath: url.path),
            let data = try? Data(contentsOf: url),
            let image = UIImage(data: data) else {
         return nil
      }
      return image
   }
   
   func saveImage(_ image: UIImage, forKey key: String) async {
      let url = cacheDirectory.appendingPathComponent(key)
      guard let data = image.pngData() else { return }
      try? data.write(to: url) // TODO: ?
      print("SYSLOG:  Saved image to \(url.lastPathComponent)")
   }
   
   func key(for url: URL) -> String {
      return url.lastPathComponent
   }
}

