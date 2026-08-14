import Foundation
import Combine

@MainActor
final class HistoryViewModel: ObservableObject {

    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var scanHistory: [ScanHistory] = []

    private let scanHistoryService = ScanHistoryService()

    func updateUserId(_ id: String?) {
        if id == nil {
            scanHistory = []
        }
    }

    func loadScanHistory(for date: Date = Date()) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            scanHistory = try await scanHistoryService.fetchHistory(date: date)
        } catch {
            scanHistory = []
            errorMessage = UserMessageMapper.message(for: error)
        }
    }

}
