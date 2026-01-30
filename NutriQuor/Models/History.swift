//
//  History.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//
import SwiftUI

struct History: Identifiable {
    let id = UUID()
    let image: Image
    let title: String
    let warning: String
    let score: String
    let time: Date
}
