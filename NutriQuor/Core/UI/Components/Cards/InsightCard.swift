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
                    .foregroundColor(Color(.white))
            }
            
            Text("Red 40 (E129)")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
            
            Text("Used in candies and dairy products. Recent studies link it to hyperactivity in children. Check for 'Allura Red' on your labels.")
                .foregroundColor(.white)
            
            NavigationLink {
                SearchDetailView(data: Nutrient(id: 1, name: "Vitamin D", description: "Aspartame is a low-calorie artificial sweetener used as a sugar substitute in many foods and beverages. It is approximately 200 times sweeter than sucrose but has a negligible caloric effect."))
            } label: {
                Text("LEARN MORE")
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color(.primary))
                    .foregroundColor(.black)
                    .cornerRadius(.smallRadius)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(
            LinearGradient(
                colors: [.black, Color(.primary).opacity(.opacityStrong)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(.cardRadius)
    }
}

#Preview {
    InsightCard()
}
