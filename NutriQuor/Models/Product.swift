//
//  Product.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/6/26.
//

import Foundation

struct ProductIngredient: Codable, Identifiable {
    let id: String?
    let name: String

    var stableID: String {
        id ?? "ingredient-\(displayName)"
    }

    var displayName: String {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return cleanName.isEmpty ? (id ?? "Thành phần") : cleanName
    }
}

struct ProductAdditive: Codable, Identifiable {
    let id: String?
    let name: String
    let ins: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case ins
    }

    init(id: String? = nil, name: String, ins: String? = nil) {
        self.id = id
        self.name = name
        self.ins = ins
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeFlexibleStringIfPresent(forKey: .id)
        name = try container.decodeFlexibleStringIfPresent(forKey: .name) ?? ""
        ins = try container.decodeFlexibleStringIfPresent(forKey: .ins)
    }

    var stableID: String {
        id ?? "additive-\(displayName)"
    }

    var displayName: String {
        let cleanName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanIns = ins?.trimmingCharacters(in: .whitespacesAndNewlines)

        if let cleanIns, !cleanIns.isEmpty {
            return "\(cleanName) (INS \(cleanIns))"
        }

        return cleanName.isEmpty ? (id ?? "Phụ gia") : cleanName
    }
}

struct ProductNutrient: Codable, Identifiable {
    let id: String?
    let name: String
    let value: String
    let unit: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case value
        case unit
    }

    init(id: String? = nil, name: String, value: String, unit: String? = nil) {
        self.id = id
        self.name = name
        self.value = value
        self.unit = unit
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeFlexibleStringIfPresent(forKey: .id)
        name = try container.decodeFlexibleStringIfPresent(forKey: .name) ?? ""
        value = try container.decodeFlexibleStringIfPresent(forKey: .value) ?? ""
        unit = try container.decodeFlexibleStringIfPresent(forKey: .unit)
    }

    var stableID: String {
        id ?? "nutrient-\(name)-\(displayValue)"
    }

    var displayValue: String {
        [value, unit]
            .compactMap { text in
                let trimmed = text?.trimmingCharacters(in: .whitespacesAndNewlines)
                return trimmed?.isEmpty == false ? trimmed : nil
            }
            .joined(separator: " ")
    }

    var normalizedKey: String {
        let source = "\(id ?? "") \(name)".lowercased()

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
    let analysisId: String?
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
    let warning: String?
    let origin: String?
    let imageRef: String?
    let s3Key: String?
    
    enum CodingKeys: String, CodingKey {
        case analysisId = "analysis_id"
        case productName = "product_name"
        case ageRange = "age_range"
        case ingredients
        case additive
        case additives
        case nutrition
        case nutritions
        case ingredientItems = "ingredient_items"
        case additiveItems = "additive_items"
        case nutrientItems = "nutrient_items"
        case manufacturer
        case mfgDate = "mfg_date"
        case expiryDate = "expiry_date"
        case netWeight = "net_weight"
        case warning
        case origin
        case imageRef = "image_ref"
        case s3Key = "s3_key"
    }

    init(
        analysisId: String? = nil,
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
        warning: String?,
        origin: String?,
        imageRef: String? = nil,
        s3Key: String? = nil
    ) {
        self.analysisId = analysisId
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
        self.warning = warning
        self.origin = origin
        self.imageRef = imageRef
        self.s3Key = s3Key
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        analysisId = try container.decodeIfPresent(String.self, forKey: .analysisId)
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
        warning = try container.decodeIfPresent(String.self, forKey: .warning)
        origin = try container.decodeIfPresent(String.self, forKey: .origin)
        imageRef = try container.decodeIfPresent(String.self, forKey: .imageRef)
        s3Key = try container.decodeIfPresent(String.self, forKey: .s3Key)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(analysisId, forKey: .analysisId)
        try container.encodeIfPresent(productName, forKey: .productName)
        try container.encodeIfPresent(ageRange, forKey: .ageRange)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(additive, forKey: .additives)
        try container.encode(nutrition, forKey: .nutritions)
        try container.encode(ingredientItems, forKey: .ingredientItems)
        try container.encode(additiveItems, forKey: .additiveItems)
        try container.encode(nutrientItems, forKey: .nutrientItems)
        try container.encodeIfPresent(manufacturer, forKey: .manufacturer)
        try container.encodeIfPresent(mfgDate, forKey: .mfgDate)
        try container.encodeIfPresent(expiryDate, forKey: .expiryDate)
        try container.encodeIfPresent(netWeight, forKey: .netWeight)
        try container.encodeIfPresent(warning, forKey: .warning)
        try container.encodeIfPresent(origin, forKey: .origin)
        try container.encodeIfPresent(imageRef, forKey: .imageRef)
        try container.encodeIfPresent(s3Key, forKey: .s3Key)
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
        if let items = try? decodeIfPresent([ProductAdditive].self, forKey: .additives) {
            return (items, items.map(\.displayName))
        }

        if let items = try? decodeIfPresent([ProductAdditive].self, forKey: .additive) {
            return (items, items.map(\.displayName))
        }

        if let names = try decodeIfPresent([String].self, forKey: .additives) {
            return ([], names)
        }

        let names = try decodeIfPresent([String].self, forKey: .additive) ?? []
        return ([], names)
    }

    func decodeFlexibleNutrients() throws -> (items: [ProductNutrient], values: [String: String]) {
        if let items = try? decodeIfPresent([ProductNutrient].self, forKey: .nutritions) {
            return (
                items,
                items.reduce(into: [:]) { result, item in
                    result[item.normalizedKey] = item.displayValue
                }
            )
        }

        if let keyedItems = try decodeKeyedNutrientsIfPresent(forKey: .nutritions) {
            return (
                keyedItems.items,
                keyedItems.values.reduce(into: [:]) { result, entry in
                    result[entry.key] = entry.value.displayValue
                }
            )
        }

        if let items = try? decodeIfPresent([ProductNutrient].self, forKey: .nutrition) {
            return (
                items,
                items.reduce(into: [:]) { result, item in
                    result[item.normalizedKey] = item.displayValue
                }
            )
        }

        if let values = try? decodeIfPresent([String: String].self, forKey: .nutritions) {
            return ([], values)
        }

        let values = try decodeIfPresent([String: String].self, forKey: .nutrition) ?? [:]
        return ([], values)
    }

    func decodeKeyedNutrientsIfPresent(
        forKey key: Product.CodingKeys
    ) throws -> (items: [ProductNutrient], values: [(key: String, value: ProductNutrient)])? {
        guard contains(key) else {
            return nil
        }

        let nested = try nestedContainer(
            keyedBy: DynamicCodingKey.self,
            forKey: key
        )

        var values: [(key: String, value: ProductNutrient)] = []
        for nestedKey in nested.allKeys.sorted(by: { $0.stringValue < $1.stringValue }) {
            if let item = try? nested.decode(ProductNutrient.self, forKey: nestedKey) {
                values.append((nestedKey.stringValue, item))
            }
        }

        guard !values.isEmpty else {
            return nil
        }

        return (values.map(\.value), values)
    }
}

private extension KeyedDecodingContainer {
    func decodeFlexibleStringIfPresent(forKey key: K) throws -> String? {
        if let value = try decodeIfPresent(String.self, forKey: key) {
            return value
        }

        if let value = try decodeIfPresent(Int.self, forKey: key) {
            return String(value)
        }

        if let value = try decodeIfPresent(Double.self, forKey: key) {
            return String(value)
        }

        return nil
    }
}

private struct DynamicCodingKey: CodingKey {
    let stringValue: String
    let intValue: Int?

    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }

    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
