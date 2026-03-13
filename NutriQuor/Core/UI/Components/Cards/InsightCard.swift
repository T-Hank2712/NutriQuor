//
//  InsightCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 13/3/26.
//

import SwiftUI

struct InsightCard: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 14) {
            
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundColor(Color(.primary))
                
                Text("INSIGHT OF THE DAY")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(Color(.primary))
            }
            
            Text("Red 40 (E129)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text("Used in candies and dairy products. Recent studies link it to hyperactivity in children. Check for 'Allura Red' on your labels.")
                .foregroundColor(.white)
            
            Button("LEARN MORE") {
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(Color(.primary))
            .foregroundColor(.black)
            .cornerRadius(10)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.black, .green.opacity(0.9)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(20)
    }
}

#Preview {
    InsightCard()
}
