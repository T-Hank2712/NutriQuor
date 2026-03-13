//
//  HomeView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct HomeView: View {
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
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // HEADER
                    HStack {
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 44, height: 44)

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Xin chào,")
                                .foregroundColor(.secondary)
                            Text("Thành Lâm")
                                .fontWeight(.semibold)
                        }
                    }
                    Text("Scans")
                        .font(.title)
                        .fontWeight(.bold)
                    HStack(spacing: 20){
                        CountScansCard()
                        IndexCard()
                    }
                    InsightCard()
                    
                    Text("Scans")
                        .font(.title)
                        .fontWeight(.bold)
                    ForEach(items) { item in
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
                .padding()
            }
            .background(Color(.systemBackground))
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView()
}

