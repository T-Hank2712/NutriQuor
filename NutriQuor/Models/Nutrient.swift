//
//  Nutrition.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//
import Foundation
struct Nutrient: Identifiable, Decodable {
    let id: Int
    let name: String
    let description: String
}

struct NutriText: Identifiable, Equatable {
    let id = UUID()
    let text: String
}

