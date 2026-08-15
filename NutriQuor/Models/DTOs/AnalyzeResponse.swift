//
//  AnalyzeResponse.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/6/26.
//

import Foundation

struct AnalyzeResponse: Codable {
    struct Additive: Codable {
        let id: String
        let name: String
        let ins: String
    }

    struct Nutrient: Codable {
        let id: String
        let name: String
        let value: String
        let unit: String
    }
    
    let productName: String
    let ageRange: String

    let ingredients: [String]
    let additive: [Additive]

    let nutrition: [Nutrient]

    let manufacturer: String
    let mfgDate: String
    let expiryDate: String

    let netWeight: String
    let warning: String
    let origin: String
    let s3Key: String

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
        case warning
        case origin
        case s3Key = "s3_key"
    }
}
