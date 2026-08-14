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

    func loadScanHistory(for date: Date = Date()) {
        guard let userId else {
            scanHistory = []
            return
        }

        scanHistory = scanHistoryManager
            .getAll(userId: userId)
            .filter {
                Calendar.current.isDate(
                    $0.scannedAt,
                    inSameDayAs: date
                )
            }
    }

    func createProduct() async {
        guard let userId else {
            errorMessage = "Vui lòng đăng nhập để xem lịch sử."
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
            errorMessage = UserMessageMapper.message(for: error)
        }
    }
}
