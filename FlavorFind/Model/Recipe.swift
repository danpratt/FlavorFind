//
//  Recipe.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/20/25.
//

import Foundation
import SwiftData

@Model
final class Recipe {
    @Attribute(.unique) var id: String
    
    var name: String
    var category: String
    var area: String
    var instructions: String
    var thumbnail: String
    var tags: String?
    var youtube: String?
    var source: String?
    
    var ingredients: [Ingredient]
    
    init(id: String, name: String, category: String, area: String, instructions: String, thumbnail: String, tags: String? = nil, youtube: String? = nil, source: String? = nil, ingredients: [Ingredient]) {
        self.id = id
        self.name = name
        self.category = category
        self.area = area
        self.instructions = instructions
        self.thumbnail = thumbnail
        self.tags = tags
        self.youtube = youtube
        self.source = source
        self.ingredients = ingredients
    }
}
