import SwiftUI

struct HistoryView: View {
    
    @State private var selectedDate = Date()
    @StateObject private var viewModel = ProductViewModel()
    
    private var filteredItems: [ProductDTO] {
        viewModel.products.sorted {
            ($0.createdAtLocal ?? .distantPast) >
            ($1.createdAtLocal ?? .distantPast)
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                
                Text("Lịch sử")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color(.colorPrimary))
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color(.colorPrimary))

                    Text("Lọc theo ngày")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)

                    Spacer()

                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .labelsHidden()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.secondarySystemBackground))
                )
                
                
                ScrollView {
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                    }

                    if viewModel.isLoading {
                        ProgressView("Đang tải lịch sử...")
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }

                    if !viewModel.isLoading,
                       viewModel.errorMessage == nil,
                       viewModel.products.isEmpty {

                        Text("Chưa có lịch sử quét")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    }
                    
                    LazyVStack(spacing: 24) {
                        ForEach(filteredItems) { item in
                            HStack(alignment: .top, spacing: 16) {

                                VStack {
                                    Rectangle()
                                        .fill(Color(.colorPrimary).opacity(.opacityStrong))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)

                                    Text(
                                        item.createdAtLocal.map(formatTime) ?? "--:--"
                                    )
                                    .font(.caption)
                                    .foregroundColor(Color(.heading))

                                    Rectangle()
                                        .fill(Color(.colorPrimary).opacity(.opacityStrong))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)
                                }
                                .frame(width: 60)

                                NavigationLink {
//                                    AnalystView(
//                                        nutriItem: item,
//                                        onDismiss: {}
//                                    )
                                } label: {
                                    HistoryItem(record: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }.padding(.top, 20)
            }
            .padding()
        }
        .task {
            await viewModel.loadProductsByDate(date: selectedDate)
        }
        .onChange(of: selectedDate) { _, newDate in
            Task {
                await viewModel.loadProductsByDate(date: newDate)
            }
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
