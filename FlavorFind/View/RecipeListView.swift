//
//  ContentView.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/20/25.
//

import SwiftUI
import SwiftData

struct RecipeListView: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel: RecipeListViewModel = RecipeListViewModel()
    @State private var selectedRecipe: Recipe?
    @State private var isAddRecipeSheetPresented: Bool = false
    @State private var isShowingFavorites: Bool = false
    
    // favorites
    @Query private var favoriteRecipes: [Recipe]
    
    // Recipes that are actually displayed
    private var displayedRecipes: [Recipe] {
        if isShowingFavorites {
            favoriteRecipes
        } else {
            viewModel.recipes
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(displayedRecipes, selection: $selectedRecipe) { recipe in
                Text(recipe.name).tag(recipe)
                    .accessibilityLabel(Text(recipe.name))
                    .accessibilityHint(Text("Double tap to view the details of this recipe"))
            }
            .searchable(text: $viewModel.searchText)
            .navigationTitle(Text("Recipes"))
            .toolbar {
                Button("Add Recipe", systemImage: "plus") {
                    isAddRecipeSheetPresented.toggle()
                }
                .accessibilityLabel(Text("Add a new recipe"))
                .accessibilityHint(Text("Double tap to manually add a new recipe to your collection"))
                
                Button("Show Favorites", systemImage: "heart.fill") {
                    isShowingFavorites.toggle()
                }
                .accessibilityLabel(Text(isShowingFavorites ? "Hide Favorites" : "Show Favorites"))
                .accessibilityHint(Text("Double tap to \(isShowingFavorites ? "hide" : "show") the list of your favorite recipes"))
            }
            .sheet(isPresented: $isAddRecipeSheetPresented, content: {
                AddRecipeView()
            })
        } detail: {
            if let selectedRecipe {
                RecipeDetailView(recipe: selectedRecipe)
            } else {
                Text("Select a recipe to see more details.")
            }
        }
    }
}

#Preview {
    RecipeListView()
}
