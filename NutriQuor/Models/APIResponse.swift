//
//  APIResponse.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 20/5/26.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let message: String
    let data: T
}
