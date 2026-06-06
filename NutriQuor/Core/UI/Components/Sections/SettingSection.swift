//
//  SettingSection.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 5/5/26.
//

import Foundation
import SwiftUI

struct SettingsSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title3)
                .foregroundColor(Color(.colorPrimary))
                .padding(.horizontal)
            
            VStack(spacing: 16) {
                content
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: .cardRadius)
                .stroke(Color.gray.opacity(.opacityMedium))
        )
    }
}

#Preview {
    VStack(spacing: 20){
        SettingsSection(title: "Test") {
            OptionCard(title: "Thêm vào yêu thích", icon: "heart", color: Color(.colorPrimary))
            OptionCard(title: "Thêm vào yêu thích", icon: "heart", color: Color(.colorPrimary))
        }
        SettingsSection(title: "Test") {
            OptionCard(title: "Thêm vào yêu thích", icon: "heart", color: Color(.colorPrimary))
            OptionCard(title: "Thêm vào yêu thích", icon: "heart", color: Color(.colorPrimary))
        }
    }
}
