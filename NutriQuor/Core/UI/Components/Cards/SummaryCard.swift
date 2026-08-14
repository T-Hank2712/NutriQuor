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
                Text("Calo")
                    .font(.title2)
                    .fontWeight(.bold)
            }
            
            HStack(spacing: 8) {
//                Tag(text: day)
//                Tag(text: date)
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
            RoundedRectangle(cornerRadius: .cardRadius)
                .fill(Color(.systemGray6))
        )
    }
}
#Preview {
    SummaryCard(title: "Calo", icon: "flame", day: "Mon", date: "27/12", value: 1000, color: .red)
}
