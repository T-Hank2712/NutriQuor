//
//  CameraView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/1/26.
//

import SwiftUI
import PhotosUI
import UIKit

struct CameraView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel = CameraViewModel()
    @StateObject private var viewState = CameraViewState()

    var body: some View {
        ZStack {
            // Camera hoặc ảnh đã chụp
            cameraOrImageView
            
            // Header và controls
            VStack {
                headerView
                Spacer()
                uploadStatusView
                controlsView
            }
        }
        .background(Color.black.ignoresSafeArea())
        .onDisappear {
            viewModel.stopSession()
        }
        .onChange(of: viewModel.images) { newImages in
            handleCapturedImage(newImages)
        }
        .onChange(of: viewState.selectedPhotoItem) { newItem in
            handleSelectedPhoto(newItem)
        }
        .alert("Lỗi", isPresented: $viewState.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            if let error = viewState.uploadError {
                Text(error)
            }
        }
        .fullScreenCover(isPresented: $viewState.showOCRResult) {
            NutritionInsights(
                nutriItem: createHistoryItem(),
                nutrition: createNutritionSample(),
                ocrData: viewState.ocrResult
            ) {
                dismiss()
            }
        }
    }
    
    // MARK: - View Components
    
    @ViewBuilder
    private var cameraOrImageView: some View {
        if let image = viewState.capturedImage {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .ignoresSafeArea()
                .clipped()
        } else {
            CameraPreview(session: viewModel.session)
                .ignoresSafeArea()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        viewModel.startSession()
                    }
                }
        }
    }
    
    private var headerView: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(Color.black.opacity(0.5)))
            }
            Spacer()
            
            if viewState.capturedImage != nil {
                Button("Sử dụng") {
                    uploadImage()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(Capsule().fill(viewModel.isUploading ? Color.gray : Color.green))
                .disabled(viewModel.isUploading)
                .overlay {
                    if viewModel.isUploading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private var uploadStatusView: some View {
        if viewModel.isUploading && !viewModel.uploadStatus.isEmpty {
            Text(viewModel.uploadStatus)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Capsule().fill(Color.black.opacity(0.7)))
                .padding(.bottom, 20)
        }
    }
    
    @ViewBuilder
    private var controlsView: some View {
        if viewState.capturedImage != nil {
            retakeButton
        } else {
            captureControls
        }
    }
    
    private var retakeButton: some View {
        Button {
            viewState.reset()
            viewModel.resetCapture()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                viewModel.startSession()
            }
        } label: {
            HStack {
                Image(systemName: "arrow.clockwise")
                Text("Chụp lại")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(Capsule().fill(Color.black.opacity(0.6)))
        }
        .padding(.bottom, 40)
    }
    
    private var captureControls: some View {
        ZStack {
            // Nút chọn ảnh từ thư viện
            HStack {
                PhotosPicker(
                    selection: $viewState.selectedPhotoItem,
                    matching: .images,
                    photoLibrary: .shared()
                ) {
                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .background(Circle().fill(Color.black.opacity(0.6)))
                }
                Spacer()
            }
            .padding(.horizontal, 40)
            
            // Nút chụp ảnh
            Button {
                viewModel.capturePhoto()
            } label: {
                ZStack {
                    Circle()
                        .strokeBorder(Color.white, lineWidth: 4)
                        .frame(width: 75, height: 75)
                    Circle()
                        .fill(Color.white)
                        .frame(width: 65, height: 65)
                }
            }
        }
        .padding(.bottom, 40)
    }
    
    // MARK: - Methods
    
    private func handleCapturedImage(_ newImages: [UIImage]) {
        guard let image = newImages.first else { return }
        viewState.capturedImage = image
        viewModel.stopSession()
    }
    
    private func handleSelectedPhoto(_ newItem: PhotosPickerItem?) {
        guard let item = newItem else { return }
        
        Task {
            if let data = try? await item.loadTransferable(type: Data.self),
               let uiImage = UIImage(data: data) {
                await MainActor.run {
                    viewState.capturedImage = uiImage
                    viewModel.stopSession()
                }
            }
        }
    }
    
    private func uploadImage() {
        guard let image = viewState.capturedImage else { return }
        
        Task {
            await viewModel.uploadAndAnalyze(image: image)
            
            // Sync state từ ViewModel sang ViewState
            await MainActor.run {
                viewState.uploadError = viewModel.uploadError
                viewState.ocrResult = viewModel.ocrResult
                
                if viewModel.ocrResult != nil {
                    viewState.showOCRResult = true
                } else if viewModel.uploadError != nil {
                    viewState.showAlert = true
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    
    private func createHistoryItem() -> History {
        History(
            image: Image(systemName: "photo"),
            title: "Phân tích dinh dưỡng",
            warning: "Đang phân tích...",
            score: "0",
            time: Date()
        )
    }
    
    private func createNutritionSample() -> Nutrition {
        Nutrition(
            name: "Sample",
            unit: "g",
            value: 0.0
        )
    }
}

#Preview {
    CameraView()
}
