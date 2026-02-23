//
//  SummaryCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 23/2/26.
//

import SwiftUI

struct SummaryCard: View {
    var title: String
    var icon: String
    var day: String
    var date: String
    var value: Double
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
            
            HStack {
                Image(systemName: icon).foregroundColor(color)
                Text("Calories")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            HStack(spacing: 8) {
                Tag(text: day)
                Tag(text: date)
            }
            
            ZStack {
                Circle()
                    .stroke(color, lineWidth: 5)
                    .frame(width: 90, height: 90)
                
                Text(value, format: .number.precision(.fractionLength(0)))
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(color)
            }.frame(maxWidth: .infinity)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(.systemGray6))
        )
    }
}
struct Tag: View {
    var text: String
    
    var body: some View {
        Text(text)
            .font(.caption)
            .padding(.horizontal, 10)
            .padding(.vertical, 6)
            .background(Color.blue.opacity(0.2))
            .cornerRadius(8)
    }
}
#Preview {
    SummaryCard(title: "Calo", icon: "flame", day: "Mon", date: "27/12", value: 1000, color: .red)
}
