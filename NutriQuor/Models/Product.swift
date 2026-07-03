//
//  Product.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/6/26.
//

import Foundation

struct Product: Codable {
    let productName: String?
    let ageRange: String?
    let ingredients: [String]
    let additive: [String]
    let nutrition: [String: String]
    let manufacturer: String?
    let mfgDate: String?
    let expiryDate: String?
    let netWeight: String?
    let allergen: String?
    let warning: String?
    let origin: String?
    
    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case ageRange = "age_range"
        case ingredients
        case additive
        case nutrition
        case manufacturer
        case mfgDate = "mfg_date"
        case expiryDate = "expiry_date"
        case netWeight = "net_weight"
        case allergen
        case warning
        case origin
    }

    init(
        productName: String?,
        ageRange: String?,
        ingredients: [String],
        additive: [String],
        nutrition: [String: String],
        manufacturer: String?,
        mfgDate: String?,
        expiryDate: String?,
        netWeight: String?,
        allergen: String?,
        warning: String?,
        origin: String?
    ) {
        self.productName = productName
        self.ageRange = ageRange
        self.ingredients = ingredients
        self.additive = additive
        self.nutrition = nutrition
        self.manufacturer = manufacturer
        self.mfgDate = mfgDate
        self.expiryDate = expiryDate
        self.netWeight = netWeight
        self.allergen = allergen
        self.warning = warning
        self.origin = origin
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        productName = try container.decodeIfPresent(String.self, forKey: .productName)
        ageRange = try container.decodeIfPresent(String.self, forKey: .ageRange)
        ingredients = try container.decodeIfPresent([String].self, forKey: .ingredients) ?? []
        additive = try container.decodeIfPresent([String].self, forKey: .additive) ?? []
        nutrition = try container.decodeIfPresent([String: String].self, forKey: .nutrition) ?? [:]
        manufacturer = try container.decodeIfPresent(String.self, forKey: .manufacturer)
        mfgDate = try container.decodeIfPresent(String.self, forKey: .mfgDate)
        expiryDate = try container.decodeIfPresent(String.self, forKey: .expiryDate)
        netWeight = try container.decodeIfPresent(String.self, forKey: .netWeight)
        allergen = try container.decodeIfPresent(String.self, forKey: .allergen)
        warning = try container.decodeIfPresent(String.self, forKey: .warning)
        origin = try container.decodeIfPresent(String.self, forKey: .origin)
    }
}
