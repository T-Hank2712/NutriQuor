import Foundation
import Combine

@MainActor
final class HistoryViewModel: ObservableObject {

    @Published var currentProduct: Product?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var scanHistory: [ScanHistory] = []

    private let productService = ProductService()
    private let scanHistoryManager = ScanHistoryManager.shared

    private var userId: String?

    func updateUserId(_ id: String?) {
        self.userId = id
        loadScanHistory()
    }

    func loadScanHistory() {
        guard let userId else {
            scanHistory = []
            return
        }

        scanHistory = scanHistoryManager.getAll(userId: userId)
    }

    func createProduct() async {
        guard let userId else {
            errorMessage = "User not logged in"
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            let product = try await productService.createProduct()
            currentProduct = product

            scanHistoryManager.save(product: product, userId: userId)
            loadScanHistory()

        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
