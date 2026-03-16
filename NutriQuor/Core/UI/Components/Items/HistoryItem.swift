//
//  HistoryItem.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import SwiftUI

struct HistoryItem: View {
    let record: History
    
    var body: some View {
        HStack {
            record.image
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(Circle())
                .padding(10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(record.title)
                    .font(.headline)
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill").foregroundColor(.yellow).opacity(.opacityStrong)
                    Text(record.warning)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                HStack {
                    Image(systemName: "circle.fill").foregroundColor(.orange).opacity(.opacityStrong)
                    Text(record.score)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            Spacer()

        }
        .overlay(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityMedium), lineWidth: 1.5)
        )
    }
}

#Preview {
    HistoryItem(record: History(
        image: Image("Example"),
        title: "Bánh quy ABC",
        warning: "Nhiều đường",
        score: "Xấu",
        time: Calendar.current.date(
            from: DateComponents(
                year: 2025,
                month: 1,
                day: 24,
                hour: 21,
                minute: 04
            )
        )!
    ))
}
