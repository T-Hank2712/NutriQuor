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
                                        formatTime(item.createdAt)
                                    )
                                    .font(.caption)
                                    .foregroundColor(Color("Heading"))

                                    Rectangle()
                                        .fill(Color("ColorPrimary").opacity(0.2))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)
                                }
                                .frame(width: 60)

                                FullScreenDetailLink {
                                    HistoryDetailView(analysisId: item.analysisId)
                                } label: {
                                    HistoryItem(record: item)
                                }
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
            await viewModel.loadScanHistory(for: selectedDate)
        }
        .onChange(of: appState.user?.id) { oldValue, newValue in
            viewModel.updateUserId(newValue)
            Task {
                await viewModel.loadScanHistory(for: selectedDate)
            }
        }
        .onChange(of: selectedDate) { _, newDate in
            Task {
                await viewModel.loadScanHistory(for: newDate)
            }
        }
        .onChange(of: appState.scanHistoryRefreshToken) { _, _ in
            Task {
                await viewModel.loadScanHistory(for: selectedDate)
            }
        }
        .restoreBottomBarOnRoot()
    }
    
    // MARK: - Format Time
    func formatTime(_ date: Date?) -> String {
        guard let date else { return "--:--" }
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

//#Preview {
//    HistoryView(viewModel: HistoryViewModel())
//        .environmentObject(AppState())
//}
