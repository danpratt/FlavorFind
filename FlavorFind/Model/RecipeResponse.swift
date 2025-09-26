//
//  RecipeResponse.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/23/25.
//

struct RecipeResponse: Decodable {
    let meals: [DecodableRecipe]
}
