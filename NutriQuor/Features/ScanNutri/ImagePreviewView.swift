//
//  ImagePreviewView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI

struct ImagePreviewView: View {
    
    let croppedImage: UIImage
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top bar
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    Text("Ảnh đã cắt")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    Spacer()
                    
                    // Placeholder để center text
                    Color.clear
                        .frame(width: 44, height: 44)
                }
                .padding()
                .background(Color.black.opacity(0.5))
                
                // Image display
                Spacer()
                
                Image(uiImage: croppedImage)
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                // Bottom buttons
                HStack(spacing: 30) {
                    Button(action: {
                        dismiss()
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.title2)
                            Text("Chụp lại")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .frame(width: 100)
                    }
                    
                    Button(action: {
                        // Xử lý phân tích ảnh
                        print("Phân tích ảnh...")
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 50))
                            Text("Phân tích")
                                .font(.caption)
                        }
                        .foregroundColor(.green)
                    }
                    
                    Button(action: {
                        saveImageToPhotoLibrary(croppedImage)
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: "square.and.arrow.down")
                                .font(.title2)
                            Text("Lưu ảnh")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .frame(width: 100)
                    }
                }
                .padding(.vertical, 30)
                .background(Color.black.opacity(0.5))
            }
        }
        .navigationBarHidden(true)
    }
    
    private func saveImageToPhotoLibrary(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        print("✅ Đã lưu ảnh vào thư viện")
    }
}

#Preview {
    if let sampleImage = UIImage(systemName: "photo") {
        ImagePreviewView(croppedImage: sampleImage)
    }
}
