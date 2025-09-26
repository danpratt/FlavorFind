//
//  DecodableRecipe.swift
//  FlavorFind
//
//  Created by Daniel Pratt on 9/25/25.
//

//  The temporary struct that exactly matches the API JSON.
struct DecodableRecipe: Decodable {
    let id: String
    let name: String
    let category: String
    let area: String
    let instructions: String
    let thumbnail: String
    let tags: String?
    let youtube: String?
    let source: String?
    let ingredients: [Ingredient]

    enum CodingKeys: String, CodingKey {
        case id = "idMeal", name = "strMeal", category = "strCategory", area = "strArea",
             instructions = "strInstructions", thumbnail = "strMealThumb", tags = "strTags",
             youtube = "strYoutube", source = "strSource"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        // ... decode all other standard properties ...
        self.category = try container.decode(String.self, forKey: .category)
        self.area = try container.decode(String.self, forKey: .area)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        self.tags = try container.decodeIfPresent(String.self, forKey: .tags)
        self.youtube = try container.decodeIfPresent(String.self, forKey: .youtube)
        self.source = try container.decodeIfPresent(String.self, forKey: .source)

        var ingredientsList: [Ingredient] = []
        let dynamicContainer = try decoder.container(keyedBy: DynamicCodingKey.self)
        for i in 1...20 {
            let ingredientKey = DynamicCodingKey(stringValue: "strIngredient\(i)")!
            let measureKey = DynamicCodingKey(stringValue: "strMeasure\(i)")!
            
            if let ingredientName = try? dynamicContainer.decode(String.self, forKey: ingredientKey),
               !ingredientName.isEmpty {
                let measureName = (try? dynamicContainer.decode(String.self, forKey: measureKey)) ?? ""
                ingredientsList.append(Ingredient(name: ingredientName, measure: measureName))
            }
        }
        self.ingredients = ingredientsList
    }
}

// Helper key for decoding
fileprivate struct DynamicCodingKey: CodingKey {
    var stringValue: String
    init?(stringValue: String) { self.stringValue = stringValue }
    var intValue: Int? { return nil }
    init?(intValue: Int) { return nil }
}
