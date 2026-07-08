//
//  Product.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/6/26.
//

import Foundation

struct ProductIngredient: Codable, Identifiable {
    let id: String
    let name: String

    var displayName: String {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleanName.isEmpty ? id : cleanName
    }
}

struct ProductAdditive: Codable, Identifiable {
    let id: String
    let name: String
    let ins: String?

    var displayName: String {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanIns = ins?.trimmingCharacters(in: .whitespacesAndNewlines)

        if let cleanIns, !cleanIns.isEmpty {
            return "\(cleanName) (INS \(cleanIns))"
        }

        return cleanName.isEmpty ? id : cleanName
    }
}

struct ProductNutrient: Codable, Identifiable {
    let id: String
    let name: String
    let value: String
    let unit: String?

    var displayValue: String {
        [value, unit]
            .compactMap { text in
                let trimmed = text?.trimmingCharacters(in: .whitespacesAndNewlines)
                return trimmed?.isEmpty == false ? trimmed : nil
            }
            .joined(separator: " ")
    }

    var normalizedKey: String {
        let source = "\(id) \(name)".lowercased()

        if source.contains("enerc") || source.contains("năng lượng") { return "energy" }
        if source.contains("procnt") || source.contains("đạm") || source.contains("protein") { return "protein" }
        if source.contains("chocdf") || source.contains("carbo") { return "carbohydrate" }
        if source.contains("sugar") || source.contains("đường") { return "sugars" }
        if source.contains("fasat") || source.contains("bão hòa") { return "saturated_fat" }
        if source.contains("fat") || source.contains("béo") { return "fat" }
        if source.contains("_na") || source.contains("natri") || source.contains("sodium") { return "sodium" }

        return name
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .replacingOccurrences(of: " ", with: "_")
    }
}

struct Product: Codable {
    let productName: String?
    let ageRange: String?
    let ingredients: [String]
    let additive: [String]
    let nutrition: [String: String]
    let ingredientItems: [ProductIngredient]
    let additiveItems: [ProductAdditive]
    let nutrientItems: [ProductNutrient]
    let manufacturer: String?
    let mfgDate: String?
    let expiryDate: String?
    let netWeight: String?
    let allergen: String?
    let warning: String?
    let origin: String?
    let s3Key: String?
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case ageRange = "age_range"
        case ingredients
        case additive
        case nutrition
        case ingredientItems = "ingredient_items"
        case additiveItems = "additive_items"
        case nutrientItems = "nutrient_items"
        case manufacturer
        case mfgDate = "mfg_date"
        case expiryDate = "expiry_date"
        case netWeight = "net_weight"
        case allergen
        case warning
        case origin
        case s3Key = "s3_key"
    }

    init(
        productName: String?,
        ageRange: String?,
        ingredients: [String],
        additive: [String],
        nutrition: [String: String],
        ingredientItems: [ProductIngredient] = [],
        additiveItems: [ProductAdditive] = [],
        nutrientItems: [ProductNutrient] = [],
        manufacturer: String?,
        mfgDate: String?,
        expiryDate: String?,
        netWeight: String?,
        allergen: String?,
        warning: String?,
        origin: String?,
        s3Key: String? = nil
    ) {
        self.productName = productName
        self.ageRange = ageRange
        self.ingredients = ingredients
        self.additive = additive
        self.nutrition = nutrition
        self.ingredientItems = ingredientItems
        self.additiveItems = additiveItems
        self.nutrientItems = nutrientItems
        self.manufacturer = manufacturer
        self.mfgDate = mfgDate
        self.expiryDate = expiryDate
        self.netWeight = netWeight
        self.allergen = allergen
        self.warning = warning
        self.origin = origin
        self.s3Key = s3Key
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        productName = try container.decodeIfPresent(String.self, forKey: .productName)
        ageRange = try container.decodeIfPresent(String.self, forKey: .ageRange)

        let decodedIngredients = try container.decodeFlexibleIngredients()
        ingredientItems = try container.decodeIfPresent([ProductIngredient].self, forKey: .ingredientItems) ?? decodedIngredients.items
        ingredients = decodedIngredients.names

        let decodedAdditives = try container.decodeFlexibleAdditives()
        additiveItems = try container.decodeIfPresent([ProductAdditive].self, forKey: .additiveItems) ?? decodedAdditives.items
        additive = decodedAdditives.names

        let decodedNutrients = try container.decodeFlexibleNutrients()
        nutrientItems = try container.decodeIfPresent([ProductNutrient].self, forKey: .nutrientItems) ?? decodedNutrients.items
        nutrition = decodedNutrients.values

        manufacturer = try container.decodeIfPresent(String.self, forKey: .manufacturer)
        mfgDate = try container.decodeIfPresent(String.self, forKey: .mfgDate)
        expiryDate = try container.decodeIfPresent(String.self, forKey: .expiryDate)
        netWeight = try container.decodeIfPresent(String.self, forKey: .netWeight)
        allergen = try container.decodeIfPresent(String.self, forKey: .allergen)
        warning = try container.decodeIfPresent(String.self, forKey: .warning)
        origin = try container.decodeIfPresent(String.self, forKey: .origin)
        s3Key = try container.decodeIfPresent(String.self, forKey: .s3Key)
    }
}

private extension KeyedDecodingContainer where K == Product.CodingKeys {
    func decodeFlexibleIngredients() throws -> (items: [ProductIngredient], names: [String]) {
        if let items = try? decodeIfPresent([ProductIngredient].self, forKey: .ingredients) {
            return (items, items.map(\.displayName))
        }

        let names = try decodeIfPresent([String].self, forKey: .ingredients) ?? []
        return ([], names)
    }

    func decodeFlexibleAdditives() throws -> (items: [ProductAdditive], names: [String]) {
        if let items = try? decodeIfPresent([ProductAdditive].self, forKey: .additive) {
            return (items, items.map(\.displayName))
        }

        let names = try decodeIfPresent([String].self, forKey: .additive) ?? []
        return ([], names)
    }

    func decodeFlexibleNutrients() throws -> (items: [ProductNutrient], values: [String: String]) {
        if let items = try? decodeIfPresent([ProductNutrient].self, forKey: .nutrition) {
            return (
                items,
                items.reduce(into: [:]) { result, item in
                    result[item.normalizedKey] = item.displayValue
                }
            )
        }

        let values = try decodeIfPresent([String: String].self, forKey: .nutrition) ?? [:]
        return ([], values)
    }
}
