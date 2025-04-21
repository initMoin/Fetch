//
//  ImageCacheTests.swift
//  FetchRecipes
//
//  Created by Moinuddin Ahmad on 4/22/25.
//

import SwiftUI
import UIKit

@MainActor
struct ImageCacheTestPreview: View {
   @State private var result: String = "Running image cache tests..."
   
   var body: some View {
       ScrollView {
           Text(result)
               .padding()
       }
       .task {
           await runTests()
       }
   }

   func runTests() async {
       var output = ""

       let cache = ImageCache.shared
       let key = "preview_test_image.png"

       let renderer = UIGraphicsImageRenderer(size: CGSize(width: 1, height: 1))
       let image = renderer.image { ctx in
           UIColor.blue.setFill()
           ctx.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
       }

       await cache.saveImage(image, forKey: key)
       if let loaded = await cache.image(forKey: key),
          loaded.pngData() == image.pngData() {
           output += "✅ testSaveAndRetrieveImage passed\n"
       } else {
           output += "❌ testSaveAndRetrieveImage failed\n"
       }

       if await cache.image(forKey: "nonexistent_image.png") == nil {
           output += "✅ testRetrieveMissingImageReturnsNil passed\n"
       } else {
           output += "❌ testRetrieveMissingImageReturnsNil failed\n"
       }

       result = output
   }
}

#Preview {
   ImageCacheTestPreview()
}
