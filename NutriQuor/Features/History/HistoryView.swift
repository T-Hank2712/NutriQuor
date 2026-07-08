import SwiftUI

struct HistoryView: View {
    
    @State private var selectedDate = Date()
    
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = HistoryViewModel()
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 18) {
                
                HStack {
                    Text("Lịch sử")
                        .font(.system(size: 30, weight: .black, design: .rounded))
                        .foregroundStyle(Color("Heading"))

                    Spacer()

                    Button {
                        Task {
                            await viewModel.createProduct()
                        }
                    } label: {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                    .foregroundStyle(Color("ColorPrimary"))
                }
                
                HStack {
                    Image(systemName: "calendar")
                        .foregroundStyle(Color("ColorPrimary"))

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
                    RoundedRectangle(cornerRadius: .cardRadius)
                        .fill(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: .cardRadius)
                                .stroke(Color.primary.opacity(0.06), lineWidth: 1)
                        )
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
                       viewModel.scanHistory.isEmpty {

                        Text("Chưa có lịch sử quét")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 40)
                    }
                    
                    LazyVStack(spacing: 24) {
                        ForEach(viewModel.scanHistory) { item in
                            HStack(alignment: .top, spacing: 16) {

                                VStack {
                                    Rectangle()
                                        .fill(Color("ColorPrimary").opacity(0.2))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)

                                    Text(
                                        formatTime(item.scannedAt)
                                    )
                                    .font(.caption)
                                    .foregroundColor(Color("Heading"))

                                    Rectangle()
                                        .fill(Color("ColorPrimary").opacity(0.2))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)
                                }
                                .frame(width: 60)

                                NavigationLink {
                                    AnalystView(
                                        product: item.product,
                                        onDismiss: {}
                                    )
                                } label: {
                                    HistoryItem(record: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }.padding(.top, 20)
            }
            .padding(20)
            .background(Color("Background"))
        }
        .task {
            viewModel.updateUserId(appState.user?.id)
        }
        .onChange(of: appState.user?.id) { oldValue, newValue in
            viewModel.updateUserId(newValue)
        }
        .onChange(of: selectedDate) { _, newDate in
            viewModel.loadScanHistory(for: newDate)
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

//#Preview {
//    HistoryView(viewModel: HistoryViewModel())
//        .environmentObject(AppState())
//}
