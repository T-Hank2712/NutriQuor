//
//  ProductViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/6/26.
//

import Foundation
import Combine

@MainActor
final class ProductViewModel: ObservableObject {

    // MARK: - Published State
    @Published var products: [ProductDTO] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // MARK: - Load Products
    func fetchProducts() async {
        isLoading = true
        errorMessage = nil

        do {
            let data = try await ProductService.getProducts()
            self.products = data
        } catch {
            self.errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    func loadProductsByDate(date: Date) async {
        isLoading = true
            errorMessage = nil

            do {
                products = try await ProductService.getProductsByDate(
                    day: Calendar.current.component(.day, from: date),
                    month: Calendar.current.component(.month, from: date),
                    year: Calendar.current.component(.year, from: date)
                )
            } catch {
                print("🔥 ERROR:", error)

                if let decodingError = error as? DecodingError {
                    print("🔥 DECODING ERROR:", decodingError)
                }
                errorMessage = error.localizedDescription
            }

            isLoading = false
    }
}
