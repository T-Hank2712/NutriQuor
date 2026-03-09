import SwiftUI
import PhotosUI
import UIKit

struct CameraView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var viewModel = CameraViewModel()
    @StateObject private var viewState = CameraViewState()
    
    var body: some View {
        
        ZStack {
            
            cameraOrImageView
            
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
        
        .onChange(of: viewModel.images) { _, newImages in
            handleCapturedImage(newImages)
        }
        
        .onChange(of: viewState.selectedPhotoItem) { _, newItem in
            handleSelectedPhoto(newItem)
        }
        
        .alert("Lỗi", isPresented: $viewState.showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewState.uploadError ?? "")
        }
        
        .fullScreenCover(isPresented: $viewState.showOCRResult) {
            NutritionInsights(
                nutriItem: createHistoryItem(),
                onDismiss: {}
            )
        }
    }
    
    // MARK: - Camera / Image
    
    @ViewBuilder
    private var cameraOrImageView: some View {
        
        if let image = viewState.capturedImage {
            
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        } else {
            
            CameraPreview(session: viewModel.session)
                .ignoresSafeArea()
                .task {
                    viewModel.startSession()
                }
        }
    }
    
    // MARK: - Header
    
    private var headerView: some View {
        
        HStack {
            
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(.black.opacity(0.6)))
            }
            
            Spacer()
            
            if viewState.capturedImage != nil {
                
                Button {
                    uploadImage()
                } label: {
                    
                    ZStack {
                        
                        Text("Sử dụng")
                            .font(.headline)
                        
                        if viewModel.isUploading {
                            ProgressView()
                                .tint(.white)
                        }
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .background(
                    Capsule()
                        .fill(viewModel.isUploading ? .gray : .green)
                )
                .disabled(viewModel.isUploading)
            }
        }
        .padding()
    }
    
    // MARK: - Upload Status
    
    @ViewBuilder
    private var uploadStatusView: some View {
        
        if viewModel.isUploading && !viewModel.uploadStatus.isEmpty {
            
            Text(viewModel.uploadStatus)
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(
                    Capsule()
                        .fill(.black.opacity(0.7))
                )
                .padding(.bottom, 20)
        }
    }
    
    // MARK: - Controls
    
    @ViewBuilder
    private var controlsView: some View {
        
        if viewState.capturedImage != nil {
            retakeButton
        } else {
            captureControls
        }
    }
    
    // MARK: Retake
    
    private var retakeButton: some View {
        
        Button {
            viewState.reset()
            viewModel.resetCapture()
            viewModel.startSession()
        } label: {
            
            HStack {
                Image(systemName: "arrow.clockwise")
                Text("Chụp lại")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding(.horizontal, 30)
            .padding(.vertical, 15)
            .background(
                Capsule()
                    .fill(.black.opacity(0.6))
            )
        }
        .padding(.bottom, 40)
    }
    
    // MARK: Capture Controls
    
    private var captureControls: some View {
        
        ZStack {
            
            HStack {
                
                PhotosPicker(
                    selection: $viewState.selectedPhotoItem,
                    matching: .images
                ) {
                    
                    Image(systemName: "photo.on.rectangle")
                        .font(.system(size: 26))
                        .foregroundColor(.white)
                        .frame(width: 55, height: 55)
                        .background(
                            Circle()
                                .fill(.black.opacity(0.6))
                        )
                }
                
                Spacer()
            }
            .padding(.horizontal, 40)
            
            
            Button {
                viewModel.capturePhoto()
            } label: {
                
                ZStack {
                    
                    Circle()
                        .strokeBorder(.white, lineWidth: 4)
                        .frame(width: 75, height: 75)
                    
                    Circle()
                        .fill(.white)
                        .frame(width: 65, height: 65)
                }
            }
        }
        .padding(.bottom, 40)
    }
    
    
    // MARK: - Image Handling
    
    private func handleCapturedImage(_ images: [UIImage]) {
        
        guard let image = images.first else { return }
        
        viewState.capturedImage = image
        viewModel.stopSession()
    }
    
    
    private func handleSelectedPhoto(_ item: PhotosPickerItem?) {
        
        guard let item else { return }
        
        Task {
            
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                
                await MainActor.run {
                    viewState.capturedImage = image
                    viewModel.stopSession()
                }
            }
        }
    }
    
    
    // MARK: Upload
    
    private func uploadImage() {
        
        guard let image = viewState.capturedImage else { return }
        
        Task {
            
            await viewModel.uploadAndAnalyze(image: image)
            
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
    
    
    // MARK: Mock Data
    
    private func createHistoryItem() -> History {
        
        History(
            image: Image(systemName: "photo"),
            title: "Phân tích dinh dưỡng",
            warning: "Đang phân tích...",
            score: "0",
            time: Date()
        )
    }
}

#Preview {
    CameraView()
}
