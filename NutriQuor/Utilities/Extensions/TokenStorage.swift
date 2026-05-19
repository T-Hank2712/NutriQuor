//
//  TokenStorage.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 18/5/26.
//

import Foundation

extension TokenStorage{
    func save(
            _ value: String,
            key: String
        ) {
            
            let data = Data(value.utf8)
            
            delete(key: key)
            
            let query: [String: Any] = [
                kSecClass as String:
                    kSecClassGenericPassword,
                
                kSecAttrService as String:
                    service,
                
                kSecAttrAccount as String:
                    key,
                
                kSecValueData as String:
                    data
            ]
            
            let status = SecItemAdd(
                query as CFDictionary,
                nil
            )
            
            if status != errSecSuccess {
                print("SAVE TOKEN ERROR:", status)
            }
        }
    func read(
           key: String
       ) -> String? {
           
           let query: [String: Any] = [
               kSecClass as String:
                   kSecClassGenericPassword,
               
               kSecAttrService as String:
                   service,
               
               kSecAttrAccount as String:
                   key,
               
               kSecReturnData as String:
                   true,
               
               kSecMatchLimit as String:
                   kSecMatchLimitOne
           ]
           
           var result: AnyObject?
           
           let status = SecItemCopyMatching(
               query as CFDictionary,
               &result
           )
           
           guard status == errSecSuccess else {
               return nil
           }
           
           guard let data = result as? Data else {
               return nil
           }
           
           return String(
               data: data,
               encoding: .utf8
           )
       }
    func delete(
            key: String
        ) {
            
            let query: [String: Any] = [
                kSecClass as String:
                    kSecClassGenericPassword,
                
                kSecAttrService as String:
                    service,
                
                kSecAttrAccount as String:
                    key
            ]
            
            SecItemDelete(
                query as CFDictionary
            )
        }
}
