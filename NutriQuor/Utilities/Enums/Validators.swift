//
//  Validators.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation

enum Validators {

    static func isValidName(_ name: String) -> Bool {

        let regex = "^[A-Za-zÀ-ỹ\\s]+$"

        return NSPredicate(
            format: "SELF MATCHES %@",
            regex
        )
        .evaluate(with: name)
    }

    static func isValidEmail(_ email: String) -> Bool {

        let regex = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"

        return NSPredicate(
            format: "SELF MATCHES %@",
            regex
        )
        .evaluate(with: email)
    }
}
