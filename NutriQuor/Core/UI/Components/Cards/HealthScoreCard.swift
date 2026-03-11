//
//  HealthScoreCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 6/3/26.
//

import SwiftUI

struct HealthScoreCard: View {
    
    var body: some View {
        VStack(spacing: 20) {
            
            HStack {
                Text("Daily Health Score")
                    .fontWeight(.semibold)
                
                Spacer()
                
                Tag(text: "4% better than yesterday", color: .green)
            }
            
            ZStack {
                Circle()
                    .trim(from: 0, to: 0.75)
                    .stroke(Color.green, style: StrokeStyle(lineWidth: 12, lineCap: .round))
                    .frame(width: 140, height: 140)
                    .rotationEffect(.degrees(135))
                
                VStack {
                    Text("82")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("/100")
                        .foregroundColor(.gray)
                    
                    Text("EXCELLENT")
                        .font(.caption)
                        .foregroundColor(.green)
                }
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray.opacity(0.2))
        )
        .cornerRadius(20)
    }
}
#Preview {
    HealthScoreCard()
}
