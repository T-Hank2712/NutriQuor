//
//  ChartData.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//
import Charts
import SwiftUI

struct ChartData: Identifiable {
    let id = UUID()
    let day: String
    let value: Double
}
