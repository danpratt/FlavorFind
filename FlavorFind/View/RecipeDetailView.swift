//
//  RecipeDetailView.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/20/25.
//

import SwiftUI
import SwiftData

struct RecipeDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Query var favoriteRecipes: [Recipe]
    
    let recipe: Recipe
    
    var isFavorite: Bool {
        favoriteRecipes.contains(where: { $0.id == recipe.id })
    }
    
    init(recipe: Recipe) {
        self.recipe = recipe
        let recipeID = recipe.id
        self._favoriteRecipes = Query(filter: #Predicate { $0.id == recipeID} )
    }
    
    var body: some View {
        ScrollView {
            // Remove the leading alignment from the VStack
            VStack(spacing: 15) {
                AsyncImage(url: URL(string: recipe.thumbnail)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    case .failure(_):
                        // Show a placeholder on failure
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .frame(height: 200)
                    case .empty:
                        // Show a progress view while loading
                        ProgressView()
                            .frame(height: 200)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                HStack(spacing: 8) {
                    VStack(alignment: .leading) {
                        Text("Category: \(recipe.category)")
                        Text("Cuisine: \(recipe.area)")
                        
                        if let tags = recipe.tags, !tags.isEmpty {
                            Text("Tags: \(tags)")
                                .font(.subheadline)
                        }
                    }
                    
                    Spacer()
                    
                }
                .font(.subheadline)
                
               Divider()

                Text("\(recipe.ingredients.count) Ingredients")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                // List all the ingredients with their measurements
                ForEach(recipe.ingredients) { ingredient in
                    HStack(spacing: 8) {
                        Text("\(ingredient.measure)")
                            .fontWeight(.semibold)
                        Text(ingredient.name)
                        Spacer()
                    }
                }
                
                Divider()
                
                Text("Instructions")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Text(recipe.instructions)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                if let youtube = recipe.youtube, !youtube.isEmpty, let url = URL(string: youtube) {
                    Divider()
                        .padding()
                    Text("Video Instructions")
                        .font(.headline)
                    WebView(url: url)
                        .frame(height: 400)
                }
            }
            .padding()
        }
        .toolbar() {
            Button {
                if isFavorite {
                    if let favoriteToDelete = favoriteRecipes.first {
                        modelContext.delete(favoriteToDelete)
                    } else {
                        print("~>No favorite to delete, this is probably an error.")
                    }
                } else {
                    modelContext.insert(recipe)
                }
                
            } label: {
                Image(systemName: isFavorite ? "heart.fill" : "heart")
                    .accessibilityLabel(isFavorite ? Text("Remove from Favorites") : Text("Add to Favorites"))
                    .accessibilityHint(Text("Double tap to \(isFavorite ? "remove" : "add") this recipe to your favorites."))
            }

        }
        .navigationTitle(recipe.name)
    }
}

#Preview {
    NavigationStack {
        RecipeDetailView(recipe: sampleRecipes[0])
    }
}
