//
//  AnalyzeResponse.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/6/26.
//

import Foundation

struct AnalyzeResponse: Codable {
    
    let productName: String
    let ageRange: String

    let ingredients: [String]
    let additive: [String]

    let nutrition: [String: String]

    let manufacturer: String
    let mfgDate: String
    let expiryDate: String

    let netWeight: String
    let allergen: String
    let warning: String
    let origin: String

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
}
