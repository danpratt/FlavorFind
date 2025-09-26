//
//  Ingredient.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/23/25.
//

import Foundation
import SwiftData

@Model
final class Ingredient {
    var name: String
    var measure: String
    
    init(name: String, measure: String) {
        self.name = name
        self.measure = measure
    }
}
