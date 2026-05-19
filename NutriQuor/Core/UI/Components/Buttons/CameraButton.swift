//
//  CameraButton.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/1/26.
//

import SwiftUI

struct CameraButton: View {
    @State private var showCamera = false

    var body: some View {
        VStack {
            Spacer()

            Button {
                showCamera = true
            } label: {
                Image(systemName: "camera.fill")
                    .font(.system(size: 26))
                    .foregroundColor(.white)
                    .frame(width: 64, height: 64)
                    .background(
                        Circle()
                            .fill(Color(.colorPrimary))
                            .shadow(radius: 10)
                    )
            }
            .offset(y: -30)
            .fullScreenCover(isPresented: $showCamera) {
                CameraView()
            }
        }
    }
}


#Preview {
    CameraButton()
}
