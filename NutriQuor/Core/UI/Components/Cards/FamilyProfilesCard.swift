//
//  FamilyProfileCard.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 9/3/26.
//

import SwiftUI

struct FamilyProfilesCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
                    
                    HStack {
                        Image(systemName: "person.2.fill").foregroundStyle(.yellow)
                        Text("Family Profiles")
                            .fontWeight(.bold)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 20) {
                            
                            VStack {
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .frame(width: 56, height: 56)
                                    .clipShape(Circle())
                                
                                Text("Leo")
                                    .font(.headline)
                                    .fontWeight(.bold)
                            }
                            
                            VStack {
                                Circle()
                                    .stroke(style: StrokeStyle(lineWidth: 2, dash: [5]))
                                    .frame(width: 56, height: 56)
                                    .overlay(
                                        Image(systemName: "plus")
                                    )
                                
                                Text("Add")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
                .padding()
                .background(Color(.systemBackground))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(.opacityMedium), lineWidth: 1)
                )
                .cornerRadius(.cardRadius)
                .shadow(radius: 2)
    }
}

#Preview {
    FamilyProfilesCard()
}
