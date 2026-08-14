import Foundation

final class ScanHistoryService {
    func fetchHistory(date: Date? = nil, limit: Int = 50) async throws -> [ScanHistory] {
        let request = try ScanHistoryAPI.listRequest(date: date, limit: limit)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<[ScanHistory]>.self
        )

        return response.data
    }

    func fetchDetail(analysisId: String) async throws -> ScanHistoryDetail {
        let request = try ScanHistoryAPI.detailRequest(analysisId: analysisId)

        let response = try await APIClient.shared.request(
            request,
            responseType: APIResponse<ScanHistoryDetail>.self
        )

        return response.data
    }
}
