//
//  SampleData.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/20/25.
//
import Foundation

// A single sample recipe for previews.
let sampleRecipe = Recipe(
    id: "52771",
    name: "Spicy Arrabiata Penne",
    category: "Vegetarian",
    area: "Italian",
    instructions: "Bring a large pot of water to a boil. Add kosher salt...",
    thumbnail: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg",
    tags: "Pasta,Curry",
    youtube: "https://www.youtube.com/watch?v=1IszT_guI08",
    source: nil,
    ingredients: [
        Ingredient(name: "penne rigate", measure: "1 pound"),
        Ingredient(name: "olive oil", measure: "1/4 cup"),
        Ingredient(name: "garlic", measure: "3 cloves"),
        Ingredient(name: "chopped tomatoes", measure: "1 tin"),
        Ingredient(name: "red chilli flakes", measure: "1/2 teaspoon"),
        Ingredient(name: "italian seasoning", measure: "1/2 teaspoon"),
        Ingredient(name: "basil", measure: "6 leaves"),
        Ingredient(name: "Parmigiano-Reggiano", measure: "sprinkling")
    ]
)

let sampleRecipeTwo = Recipe(id: "52342", name: "Firecracker Pasta", category: "Vegetarian", area: "Italian", instructions: "These are some instructions", thumbnail: "https://www.themealdb.com/images/media/meals/ustsqw1468250014.jpg", tags: "Pasta,Curry", youtube: "https://www.youtube.com/watch?v=1IszT_guI08", source: nil, ingredients: [
    Ingredient(name: "rigate", measure: "1 pound"),
    Ingredient(name: "olive oil", measure: "1/4 cup"),
    Ingredient(name: "garlic", measure: "3 cloves"),
    Ingredient(name: "chopped tomatoes", measure: "1 tin"),
    Ingredient(name: "red chilli flakes", measure: "1/2 teaspoon"),
    Ingredient(name: "italian seasoning", measure: "1/2 teaspoon"),
    Ingredient(name: "basil", measure: "6 leaves"),
    Ingredient(name: "Parmigiano-Reggiano", measure: "sprinkling")
])

// The array now holds your single sample.
let sampleRecipes: [Recipe] = [sampleRecipe, sampleRecipeTwo]
