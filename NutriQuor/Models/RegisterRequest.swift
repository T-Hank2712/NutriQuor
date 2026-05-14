//
//  RegisterRequest.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/5/26.
//

import SwiftUI

struct RegisterRequest: Codable {
    let first_name: String
    let last_name: String
    let email: String
    let password: String
    let confirm_password: String
}
