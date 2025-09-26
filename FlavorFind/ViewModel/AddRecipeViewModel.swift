//
//  AddRecipeViewModel.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/21/25.
//

import SwiftUI
import Combine

class AddRecipeViewModel: ObservableObject {
    
    @Published var name: String = ""
    @Published var ingredients: [Ingredient] = []
    @Published var instructions: String = ""
    
    func addIngredient() {
//        ingredients.append(Ingredient())
    }
    
    func removeIngredient(at offsets: IndexSet) {
        ingredients.remove(atOffsets: offsets)
    }
    
    func saveRecipe() {
        print("Saving recipe: \(name)")
        print("Ingredients: \(ingredients)")
        print("Instructions: \(instructions)")
    }
}

