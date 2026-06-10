//
//  ProductCountResponse.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/6/26.
//

import Foundation

struct ProductCountResponse: Decodable {
    let day: Int
    let month: Int
    let year: Int
    let count: Int
}
