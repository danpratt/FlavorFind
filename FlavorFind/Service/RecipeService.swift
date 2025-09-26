//
//  RecipeService.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/23/25.
//

import Foundation

enum RecipeServiceError: Swift.Error {
    case invalidURL
    case decodingError(Error)
    case networkError(Error)
}

protocol RecipeServiceProtocol {
    func searchRecipes(query: String) async throws -> [Recipe]
}

struct RecipeService: RecipeServiceProtocol {
    
    func searchRecipes(query: String) async throws -> [Recipe] {
        let endpoint = "https://www.themealdb.com/api/json/v1/1/search.php?s=\(query)"
                
                // Safely encode the search query.
                guard let urlString = endpoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                      let url = URL(string: urlString) else {
                    throw RecipeServiceError.invalidURL
                }
                
                let data: Data
                let response: URLResponse
                
                // Simplified do-catch for network errors
                do {
                    (data, response) = try await URLSession.shared.data(from: url)
                    print(response)
                } catch {
                    throw RecipeServiceError.networkError(error)
                }
                
                // Simplified do-catch for decoding errors
                do {
                    let decoder = JSONDecoder()
                    let recipeResponse = try decoder.decode(RecipeResponse.self, from: data)
                    return recipeResponse.meals.map { decodableRecipe in
                                Recipe(id: decodableRecipe.id,
                                       name: decodableRecipe.name,
                                       category: decodableRecipe.category,
                                       area: decodableRecipe.area,
                                       instructions: decodableRecipe.instructions,
                                       thumbnail: decodableRecipe.thumbnail,
                                       tags: decodableRecipe.tags,
                                       youtube: decodableRecipe.youtube,
                                       source: decodableRecipe.source,
                                       ingredients: decodableRecipe.ingredients)
                            }
                    
                } catch {
                    // Throw a specific decoding error with the original error attached.
                    throw RecipeServiceError.decodingError(error)
                }
    }
}

// MARK: - Concurrency Sendability
// In Swift 6 strict concurrency, values crossing actor boundaries must be Sendable.
// We assert sendability here to avoid cross-actor return/thrown value issues.
extension Recipe: @unchecked Sendable {}

extension RecipeServiceError: @unchecked Sendable {}
