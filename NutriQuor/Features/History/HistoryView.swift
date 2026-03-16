import SwiftUI

struct HistoryView: View {
    @State private var selectedDate = Date()
    let items: [History] = [
        History(
            image: Image("Example"),
            title: "Bánh quy ABC",
            warning: "Nhiều đường",
            score: "Xấu",
            time: Calendar.current.date(
                from: DateComponents(year: 2025, month: 1, day: 24, hour: 21, minute: 04)
            )!
        ),
        History(
            image: Image("Example"),
            title: "Sữa tươi XYZ",
            warning: "Ít đường",
            score: "Tốt",
            time: Calendar.current.date(
                from: DateComponents(year: 2025, month: 1, day: 24, hour: 18, minute: 15)
            )!
        )
    ]
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading) {
                
                Text("Lịch sử")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color(.primary))
                
                ScrollView {
                    DatePicker(
                        "",
                        selection: $selectedDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    .labelsHidden()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Hôm nay")
                        .font(.title2)
                        .bold()
                        .foregroundColor(.gray)
                        .padding(.vertical, 8)
                    
                    LazyVStack(spacing: 24) {
                        ForEach(items.sorted(by: { $0.time > $1.time })) { item in
                            
                            HStack(alignment: .top, spacing: 16) {
                                
                                // MARK: - Time + Timeline
                                VStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(.opacityMedium))
                                        .frame(width: 2)
                                        .frame(maxHeight: .infinity)
                                    Text(formatTime(item.time))
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Rectangle()
                                        .fill(Color.gray.opacity(.opacityMedium))
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
    }
    
    // MARK: - Format Time
    
    func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    HistoryView()
}
