# FetchRecipes

A simple SwiftUI-based recipe app built for the Fetch take-home challenge. It pulls recipe data from a remote API then displays them in a scrollable and refreshable list. The app is written entirely in Swift using modern concurrency only - no third-party dependencies included.

---

## Summary

- Displays a list of recipes with name, cuisine type, and thumbnail
- Refreshable UI with graceful handling of malformed or empty data
- Custom-built image caching system with disk storage
- Fully async/await-powered networking and image loading
- Modular and testable codebase using Swift’s latest language features

---

## Focus Areas

I focused on these key areas during development:

- **Clean architecture**: Separated networking, models, and views for maintainability
- **Modern Swift tools**: Used `async/await`, `NavigationStack`, and `@Observable`
- **Custom image caching**: Manually implemented a file-based image cache using `FileManager`
- **Error handling**: Ensured the app responds clearly to both malformed and empty data scenarios
- **UI feedback**: Included loading indicators, error messages, and an empty state prompt

---

## Time Spent

I spent approximately **4-5 hours** on the project:
- 1-2h setting up project and models
- 2-3h building views and core logic
- 1h testing various API responses
- 1h on polish, error states, and async-safe caching

---

## Trade-offs & Decisions

- Skipped UI testing in favor of preview-driven testing using SwiftUI’s `#Preview`
- Image caching uses UIImage and FileManager internally, since SwiftUI does not currently offer native disk-level image support. All user interface components are built entirely with SwiftUI, as required.
- Limited to one screen to meet the scope and time expectations

---

## Weakest Part of the Project

The UI is intentionally minimal. While functional and adaptive, there’s room for future improvement like search, filtering, or expanded recipe details.

---

## Additional Notes

- All network requests respect Swift Concurrency
- `ImageCache` and `ImageLoader` are concurrency-safe via `actor`
- Test views are used in place of `XCTest`, aligning with SwiftUI’s latest preview architecture
- Targeting iOS 17+, built using Xcode 16.3

---

## Screenshots

_(Insert screenshots or screen recordings of the app here)_

---

Thanks for reviewing!
