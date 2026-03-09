//
//  HealthScoreRing.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 8/3/26.
//

import SwiftUI

struct HealthScoreRing: View {
    var title: String
    var score: Double
    var size: CGFloat = 220
    var lineWidth: CGFloat = 16
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: lineWidth)
                    .frame(width: size, height: size)
                
                Circle()
                    .trim(from: 0, to: score / 100)
                    .stroke(
                        Color.green,
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
                    .frame(width: size, height: size)
                
                VStack {
                    
                    Text("\(Int(score))")
                        .font(.system(size: size * 0.22, weight: .bold))
                    
                    Text(title)
                        .font(.system(size: size * 0.07))
                        .foregroundColor(.green)
                    
                    Text("TODAY")
                        .font(.system(size: size * 0.06))
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}
#Preview {
    HealthScoreRing(title: "HEALTH SCORE",score: 70, size: 220, lineWidth: 16)
}
