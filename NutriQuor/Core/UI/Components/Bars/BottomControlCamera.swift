//
//  BottomControlCamera.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI

struct BottomControlCamera: View {
    var onPickImage: () -> Void = {}
    var onCapture: () -> Void = {}
    
    var body: some View {
        HStack{
            CircleButton(icon: "photo.fill")
                .onTapGesture {
                    onPickImage()
                }
            Spacer()
            CaptureButton()
                .onTapGesture {
                    onCapture()
                }
            Spacer()
            CircleButton(icon: "flashlight.off.fill")
        }
    }
}

#Preview {
    BottomControlCamera()
}
