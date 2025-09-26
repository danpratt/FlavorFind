//
//  FlavorFindApp.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/20/25.
//

import SwiftUI
import SwiftData

@main
struct FlavorFindApp: App {
    var body: some Scene {
        WindowGroup {
            RecipeListView()
        }
        .modelContainer(for: [Recipe.self, Ingredient.self])
    }
}
