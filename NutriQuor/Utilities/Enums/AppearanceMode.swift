//
//  AppearanceMode.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 5/5/26.
//

import Foundation
import SwiftUI

enum AppearanceMode: String, CaseIterable {
    case system
    case light
    case dark
    
    var colorScheme: ColorScheme? {
        switch self {
        case .system:
            return nil
        case .light:
            return .light
        case .dark:
            return .dark
        }
    }
}
