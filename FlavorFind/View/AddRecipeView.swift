//
//  AddRecipeView.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/21/25.
//

import SwiftUI

struct AddRecipeView: View {
    @StateObject var viewModel: AddRecipeViewModel = AddRecipeViewModel()
    
    var body: some View {
        Form {
            Section(header: Text("Recipe Info")) {
                TextField("Recipe Name", text: $viewModel.name)
            }
            
            Section(header: Text("Ingredients")) {
//                ForEach($viewModel.ingredients) { $ingredient in
//                    TextField("New Ingredient", text: $ingredient.name)
//                }
//                .onDelete(perform: viewModel.removeIngredient)
//                
//                Button("Add Ingredient") {
//                    viewModel.addIngredient()
//                }
            }
            
            Section(header: Text("Instructions")) {
                TextEditor(text: $viewModel.instructions)
            }
            
            Section {
                Button("Save Recipe") {
                    viewModel.saveRecipe()
                }
            }
        }
    }
}

#Preview {
    AddRecipeView()
}
