//
//  HomeView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject var appState: AppState

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
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {

                    // MARK: - Header
                    HStack(alignment: .center) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Xin chào 👋")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundStyle(.secondary)
                            Text("\(appState.profile?.lastName ?? "") \(appState.profile?.firstName ?? "Người dùng")")
                                .font(.system(size: 24, weight: .black, design: .rounded))
                                .foregroundStyle(.primary)
                                .kerning(-0.3)
                        }

                        Spacer()

                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [Color("ColorPrimary"), Color("AccentPinkLight")],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 46, height: 46)
                                .shadow(color: Color("ColorPrimary").opacity(0.5), radius: 10, y: 4)

                            Image(systemName: "person.fill")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                        }
                    }
                    .padding(.top, 8)

                    // MARK: - Stats Section
                    VStack(alignment: .leading, spacing: 14) {
                        HomeSectionLabel(text: "THỐNG KÊ HÔM NAY")

                        HStack(spacing: 14) {
                            CountScansCard()
                            IndexCard()
                        }
                    }

                    // MARK: - Insight
                    VStack(alignment: .leading, spacing: 14) {
                        HomeSectionLabel(text: "GỢI Ý CHO BẠN")
                        InsightCard()
                    }

                    // MARK: - Recent Scans
                    VStack(alignment: .leading, spacing: 14) {
                        HStack {
                            HomeSectionLabel(text: "LỊCH SỬ QUÉT GẦN ĐÂY")
                            Spacer()
                            Button {
                                // view all
                            } label: {
                                Text("Xem tất cả")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundStyle(Color("ColorPrimary"))
                            }
                        }

                        VStack(spacing: 12) {
                            ForEach(items) { item in
                                NavigationLink {
                                    AnalystView(nutriItem: item, onDismiss: {})
                                } label: {
                                    HomeHistoryItem(record: item)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

// MARK: - Preview
#Preview {
    HomeView().environmentObject(AppState())
}
