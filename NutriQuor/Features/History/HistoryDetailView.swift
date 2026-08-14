import SwiftUI

struct HistoryDetailView: View {
    let analysisId: String

    @State private var product: Product?
    @State private var isLoading = false
    @State private var errorMessage: String?

    private let service = ScanHistoryService()

    var body: some View {
        Group {
            if let product {
                AnalystView(product: product, onDismiss: {})
            } else if isLoading {
                VStack(spacing: 12) {
                    ProgressView()
                    Text("Đang tải kết quả phân tích...")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Background"))
            } else {
                VStack(spacing: 14) {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(Color("WarningAmber"))

                    Text(errorMessage ?? "Không thể mở lịch sử quét này.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("Background"))
            }
        }
        .task {
            await loadDetail()
        }
    }

    private func loadDetail() async {
        guard product == nil else { return }

        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let detail = try await service.fetchDetail(analysisId: analysisId)
            product = detail.result
        } catch {
            errorMessage = UserMessageMapper.message(for: error)
        }
    }
}
