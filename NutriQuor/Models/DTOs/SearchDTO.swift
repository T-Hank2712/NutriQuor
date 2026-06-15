//
//  SearchDTO.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 27/4/26.
//

import Foundation

struct SearchDTO: Identifiable, Codable{
    let id: String
    let name: String
    let code: String?
    let description: String?
    let type: String
}
