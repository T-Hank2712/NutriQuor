//
//  ImagePreviewView.swift
//  NutriQuor
//

import SwiftUI

struct ImagePreviewView: View {
    
    let croppedImage: UIImage
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var appState: AppState
    @StateObject private var viewModel = ScanNutriViewModel()
    
    @State private var selectedMode = "Tôi"
    @State private var showDropdown = false
    @State private var showAnalyzedProduct = false
    
    let modes = ["Tôi","Anh", "Chị", "Ba", "Mẹ"]
    
    var body: some View {
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                // Top bar
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }
                    
                    Spacer()
                    
                    // Mode Button
                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.8)) {
                            showDropdown.toggle()
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Text(selectedMode.uppercased())
                                .fontWeight(.bold)
                            
                            Image(systemName: "chevron.down")
                                .font(.system(size: 12, weight: .bold))
                                .rotationEffect(.degrees(showDropdown ? 180 : 0))
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 8)
                        .background(
                            Capsule()
                                .stroke(Color.white, lineWidth: 2)
                        )
                    }
                    
                    Spacer()
                    
                    Color.clear
                        .frame(width: 44, height: 44)
                }
                .padding()
                .background(Color.black.opacity(.opacityStrong))
                
                // Image display
                Spacer()
                
                Image(uiImage: croppedImage)
                    .resizable()
                    .scaledToFit()
                
                Spacer()
                
                // Bottom buttons
                HStack(spacing: 30) {
                    
                    Button {
                        dismiss()
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: "arrow.counterclockwise")
                                .font(.title2)
                            Text("Chụp lại")
                                .font(.caption)
                        }
                        .foregroundColor(.white)
                        .frame(width: 100)
                    }
                    
                    Button {
                        Task {
                            await viewModel.analyze(
                                image: croppedImage,
                                userId: appState.user?.id
                            )

                            if viewModel.analyzedProduct != nil {
                                showAnalyzedProduct = true
                            }
                        }
                    } label: {
                        VStack(spacing: 8) {
                            if viewModel.isLoading {
                                ProgressView()
                                    .tint(.green)
                                    .frame(width: 50, height: 50)
                            } else {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.system(size: 50))
                            }
                            Text("Phân tích")
                                .font(.caption)
                        }
                        .foregroundColor(.green)
                    }
                    .disabled(viewModel.isLoading)
                    
                    Button {
                        saveImageToPhotoLibrary(croppedImage)
                    } label: {
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
                .background(Color.black.opacity(.opacityStrong))
            }
            
            // Dropdown (nằm trên cùng)
            if showDropdown {
                VStack {
                    
                    DropdownModes(
                        modes: modes,
                        selectedMode: $selectedMode,
                        showDropdown: $showDropdown
                    )
                    .padding(.top, 95)
                    .transition(.opacity.combined(with: .move(edge: .top)))
                    
                    Spacer()
                }
                .zIndex(10)
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $showAnalyzedProduct) {
            if let product = viewModel.analyzedProduct {
                AnalystView(product: product, onDismiss: {})
            }
        }
        .alert(
            "Không thể phân tích ảnh",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { if !$0 { viewModel.errorMessage = nil } }
            )
        ) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
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
