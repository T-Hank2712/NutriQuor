//
//  ScanHistory.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 16/6/26.
//

import Combine
import Foundation

struct ScanHistory: Codable, Identifiable {
    let id: UUID
    let scannedAt: Date
    let product: Product
}
