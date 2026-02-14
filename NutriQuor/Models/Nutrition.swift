//
//  Nutrition.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 26/1/26.
//
import Foundation
struct Nutrition{
    let name: String
    let unit: String
    let value: Double
}

struct NutriText: Identifiable, Equatable {
    let id = UUID()
    let text: String
}

