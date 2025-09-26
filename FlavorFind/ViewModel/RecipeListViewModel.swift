//
//  RecipeListViewModel.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/23/25.
//

import SwiftUI
import Combine
import SwiftData
import CoreData

class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = ""
    
    private let recipieService: RecipeServiceProtocol
    private var cancellables: Set<AnyCancellable> = []
    
    
    init(service: RecipeServiceProtocol = RecipeService()) {
        self.recipieService = service
        Task {
            try? await fetchRecipes(query: "Chicken")
        }
        
        $searchText
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] searchText in
                if searchText.isEmpty {
                    self?.recipes = []
                } else {
                    Task {
                        try? await self?.fetchRecipes(query: searchText)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func fetchRecipes(query: String) async throws {
        guard !query.isEmpty else { return }
        
        let results = try await recipieService.searchRecipes(query: query)
        await MainActor.run { [weak self] in
            guard let self = self else { return }
            self.recipes = results
        }
    }
}

