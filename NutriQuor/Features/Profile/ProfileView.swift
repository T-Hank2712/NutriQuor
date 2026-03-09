//
//  ProfileView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 12/1/26.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ZStack(alignment: .bottomTrailing) {
                    
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 96, height: 96)
                        .clipShape(Circle())
                    
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                        Text("Premium")
                    }
                    .font(.caption2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 3)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .offset(x: 6, y: 6)
                }
                
                Text("Lâm Tấn Thành")
                    .font(.title3)
                    .fontWeight(.bold)
                
                Button {
                    
                } label: {
                    
                    HStack {
                        Image(systemName: "crown.fill")
                        Text("Manage Subscription")
                            .fontWeight(.bold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                }
                
                PrimaryGoalsCard()
                
                MedicalConditionsCard()
                
                AllergiesCard()
            }
            .padding()
        }
    }
}

#Preview {
    ProfileView()
}
