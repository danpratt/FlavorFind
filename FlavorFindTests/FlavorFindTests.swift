//
//  FlavorFindTests.swift
//  FlavorFindTests
//
//  Created by Daniel Pratt on 9/20/25.
//

import Testing

@testable import FlavorFind

class MockRecipeService: RecipeServiceProtocol {
    // A property to hold the data we want our mock to return.
    var recipesToReturn: [Recipe]
    var searchCallCount: Int = 0
    
    // We can initialize it with the data we want for a specific test.
    init(recipesToReturn: [Recipe]) {
        self.recipesToReturn = recipesToReturn
    }
    
    func searchRecipes(query: String) async throws -> [Recipe] {
        searchCallCount += 1
        if query.isEmpty {
            return [] // A real API might return nothing for an empty query
        }
        
        let filteredRecipes = recipesToReturn.filter { recipe in
            recipe.name.lowercased().contains(query.lowercased())
        }
        return filteredRecipes
    }
}

@MainActor
struct FlavorFindTests {
    
    @Test
    func initialFetchLoadsRecipes() async throws {
        let mockService = MockRecipeService(recipesToReturn: [sampleRecipe])
        let model = RecipeListViewModel(service: mockService)
        
        try await Task.sleep(for: .seconds(0.1))
        
        #expect(!model.recipes.isEmpty)
    }
    
    @Test("Search with result")
    func searchWithResult() async throws {
        let mockService = MockRecipeService(recipesToReturn: [sampleRecipeTwo, sampleRecipe])
        let model = RecipeListViewModel(service: mockService)
        
        model.searchText = "Penne"
        
        try await Task.sleep(for: .seconds(0.6))
        
        #expect(!model.recipes.isEmpty)
        #expect(model.recipes.first?.name == "Spicy Arrabiata Penne")
    }
    
    @Test("Search with no result")
    func searchWithNoResult() async throws {
        let mockService = MockRecipeService(recipesToReturn: [sampleRecipe, sampleRecipeTwo])
        let model = RecipeListViewModel(service: mockService)
        
        model.searchText = "Penne"
        
        try await Task.sleep(for: .seconds(0.6))
        
        #expect(!model.recipes.isEmpty)
        #expect(model.recipes.first?.name == "Spicy Arrabiata Penne")
        
        model.searchText = ""
        
        try await Task.sleep(for: .seconds(0.6))
        
        #expect(model.recipes.isEmpty)
    }
    
    @Test("Debounce Logic Test")
    func debounceLogicTest() async throws {
        let mockService = MockRecipeService(recipesToReturn: [sampleRecipe, sampleRecipeTwo])
        let model = RecipeListViewModel(service: mockService)
        
        // Wait for the initial fetch in init() to complete.
        try await Task.sleep(for: .seconds(0.1))
            
        // Reset the counter *after* the initial fetch.
        mockService.searchCallCount = 0
        
        model.searchText = "P"
        model.searchText = "Pe"
        model.searchText = "Pen"
        
        try await Task.sleep(for: .seconds(0.6))
        
        #expect(mockService.searchCallCount == 1)
    }

}
