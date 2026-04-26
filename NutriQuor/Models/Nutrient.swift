//
//  Nutrition.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//
import Foundation
struct Nutrient: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let image: String
    let effects: [HealthEffect]
    let found_in: [FoodCategory]
}

struct NutriText: Identifiable, Equatable {
    let id = UUID()
    let text: String
}

