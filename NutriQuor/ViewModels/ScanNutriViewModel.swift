//
//  ScanNutriViewModel.swift
//  NutriQuor
//

import Foundation
import UIKit
import Combine

@MainActor
final class ScanNutriViewModel: ObservableObject {
    @Published var analyzedProduct: Product?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let productService = ProductService()
    private let scanHistoryManager = ScanHistoryManager.shared

    func analyze(image: UIImage, userId: String?) async {
        guard let userId else {
            errorMessage = "Vui lòng đăng nhập để phân tích ảnh."
            return
        }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let product = try await productService.analyzeProduct(image: image)
            analyzedProduct = product
            scanHistoryManager.save(product: product, userId: userId)
        } catch {
            errorMessage = UserMessageMapper.message(for: error)
        }
    }
}
