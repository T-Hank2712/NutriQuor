import SwiftUI

struct HistoryView: View {
    @State private var items: [History] = []
    @State private var errorMessage: String?
    @State private var isLoading = false
    
    private var filteredItems: [History] {
        items
            .sorted(by: { $0.time > $1.time })
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                
                Text("Lịch sử")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color(.colorPrimary))
                
                ScrollView {
                    if let errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    if isLoading {
                        ProgressView("Đang tải lịch sử...")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !isLoading, errorMessage == nil, items.isEmpty {
                        Text("Chưa có lịch sử quét")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)
                    }
                    
                    LazyVStack(spacing: 24) {
                        ForEach(filteredItems) { item in
                            HStack(alignment: .top, spacing: 16) {
                                
                                // MARK: - Time + Timeline
                                VStack {
                                    Rectangle()
                                        .fill(Color(.colorPrimary).opacity(.opacityStrong))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)
                                    Text(formatTime(item.time))
                                        .font(.caption)
                                        .foregroundColor(Color(.heading))
                                    
                                    Rectangle()
                                        .fill(Color(.colorPrimary).opacity(.opacityStrong))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)
                                }
                                .frame(width: 60)
                                
                                // MARK: - Card
                                NavigationLink {
                                    AnalystView(
                                        nutriItem: item,
                                        onDismiss: {}
                                    )
                                } label: {
                                    HistoryItem(record: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .task {
            await loadProducts()
        }
    }

    @MainActor
    private func loadProducts() async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }

        do {
            let products = try await ProductAPI.fetchProducts()
            items = products.map { p in
                History(
                    image: Image("Example"),
                    title: p.productName,
                    warning: p.warning ?? "Không có cảnh báo",
                    score: p.nutrition?.sugar ?? "Chưa có",
                    time: parseDate(p.createdAtLocal) ?? parseDate(p.createdAt) ?? Date()
                )
            }
        } catch {
            errorMessage = "Không tải được dữ liệu. Kiểm tra API server và baseURL rồi thử lại."
        }
    }
    
    // MARK: - Format Time
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }

    private func parseDate(_ raw: String?) -> Date? {
        guard let raw else { return nil }

        let isoWithFraction = ISO8601DateFormatter()
        isoWithFraction.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

        let isoWithoutFraction = ISO8601DateFormatter()
        isoWithoutFraction.formatOptions = [.withInternetDateTime]

        if let d = isoWithFraction.date(from: raw) ?? isoWithoutFraction.date(from: raw) {
            return d
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = .current

        let formats = [
            "yyyy-MM-dd HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss",
            "yyyy-MM-dd'T'HH:mm:ss.SSS",
            "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        ]

        for format in formats {
            formatter.dateFormat = format
            if let d = formatter.date(from: raw) {
                return d
            }
        }

        return nil
    }
}

#Preview {
    HistoryView()
}
