//
//  AppConfig.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 25/4/26.
//

import Foundation

final class AppConfig {
    static let shared = AppConfig()

    let devBaseURL = "http://127.0.0.1:8000"

    private init() {}
}
