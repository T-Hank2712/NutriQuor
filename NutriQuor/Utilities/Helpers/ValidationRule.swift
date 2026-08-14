//
//  ValidationRule.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 15/5/26.
//

import Foundation

struct ValidationRule{
    static func required(_ value: String) -> String? {
        value.trimmingCharacters(in: .whitespaces).isEmpty ? "Vui lòng nhập thông tin này." : nil
    }
    
    static func name(_ value: String) -> String? {
        let trimmed = value.trimmingCharacters(in: .whitespaces)
        
        let regex = #"^[A-Za-zÀ-ỹ\s]+$"#
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        return predicate.evaluate(with: trimmed) ? nil : "Tên chỉ được chứa chữ cái."
    }
    
    static func email(_ value: String) -> String? {
        let regex =
        #"^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$"#
        
        let predicate = NSPredicate(
            format: "SELF MATCHES[c] %@",
            regex
        )
        
        return predicate.evaluate(with: value)
        ? nil
        : "Email không đúng định dạng."
    }
    static func password(_ value: String) -> String? {
        
        if value.count < 8 {
            return "Mật khẩu cần có ít nhất 8 ký tự."
        }
        
        return nil
    }
}
