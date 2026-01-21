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
    @State private var capturedImage: UIImage?
    @State private var cropRect: CGRect = .zero
    @State private var previewSize: CGSize = .zero
    @State private var isUploading = false
    @State private var uploadError: String?
    @State private var showAlert = false
    @State private var ocrResult: OCRData?
    @State private var showOCRResult = false
    @State private var uploadStatus = ""
    @State private var selectedPhotoItem: PhotosPickerItem?

    var body: some View {
        ZStack {
            if let image = capturedImage {
                // Hiển thị ảnh đã chụp
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .ignoresSafeArea()
            } else {
                // Camera Preview
                CameraPreview(session: viewModel.session)
                    .ignoresSafeArea()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            viewModel.startSession()
                        }
                    }
                
                // Overlay với khung crop
                GeometryReader { geometry in
                    let frameWidth = geometry.size.width * 0.65
                    let frameHeight = geometry.size.height * 0.4
                    
                    ZStack {
                        // Làm tối vùng ngoài khung
                        Color.black.opacity(0.5)
                        
                        // Khung crop trong suốt
                        Rectangle()
                            .frame(width: frameWidth, height: frameHeight)
                            .blendMode(.destinationOut)
                    }
                    .compositingGroup()
                    
                    // Viền khung crop
                    Rectangle()
                        .strokeBorder(Color.white, lineWidth: 3)
                        .frame(width: frameWidth, height: frameHeight)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .onAppear {
                            // Lưu thông tin crop rect
                            cropRect = CGRect(
                                x: (geometry.size.width - frameWidth) / 2,
                                y: (geometry.size.height - frameHeight) / 2,
                                width: frameWidth,
                                height: frameHeight
                            )
                            previewSize = geometry.size
                        }
                }
                .ignoresSafeArea()
            }
            
            // Header và controls
            VStack {
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
                    
                    if capturedImage != nil {
                        Button("Sử dụng") {
                            uploadImage()
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(isUploading ? Color.gray : Color.green))
                        .disabled(isUploading)
                        .overlay {
                            if isUploading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                // Hiển thị status khi đang upload
                if isUploading && !uploadStatus.isEmpty {
                    Text(uploadStatus)
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Capsule().fill(Color.black.opacity(0.7)))
                        .padding(.bottom, 20)
                }
                
                // Nút chụp
                if capturedImage != nil {
                    Button {
                        capturedImage = nil
                        viewModel.images.removeAll()
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
                } else {
                    ZStack {
                            // Nút chọn ảnh từ thư viện
                            HStack {
                                PhotosPicker(
                                    selection: $selectedPhotoItem,
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
            }
        }
        .background(Color.black.ignoresSafeArea())
        .onDisappear {
            viewModel.stopSession()
        }
        .onChange(of: viewModel.images) { newImages in
            if let image = newImages.first {
                // Crop ảnh theo khung
                let croppedImage = cropImageToRect(image: image, previewSize: previewSize, cropRect: cropRect)
                capturedImage = croppedImage
                viewModel.stopSession()
            }
        }
        .onChange(of: selectedPhotoItem) { newItem in
            guard let item = newItem else { return }

            Task {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {

                    await MainActor.run {
                        // Vì ảnh từ thư viện đã đúng tỉ lệ → không crop
                        capturedImage = uiImage
                        viewModel.stopSession()
                    }
                }
            }
        }
        .alert("Lỗi", isPresented: $showAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            if let error = uploadError {
                Text(error)
            }
        }
        .sheet(isPresented: $showOCRResult) {
            OCRResultView(ocrData: ocrResult) {
                dismiss()
            }
        }
    }
    
    private func uploadImage() {
        guard let image = capturedImage else { return }
        
        isUploading = true
        ocrResult = nil
        uploadStatus = "Đang upload ảnh..."
        
        Task {
            do {
                await MainActor.run {
                    uploadStatus = "Đang phân tích OCR..."
                }
                
                let result = try await ImageUploadService.shared.uploadAndAnalyzeImage(image)
                
                await MainActor.run {
                    isUploading = false
                    uploadStatus = ""
                    ocrResult = result
                    uploadError = nil
                    showOCRResult = true
                    print("Kết quả OCR: \(result.fullText)")
                }
            } catch {
                await MainActor.run {
                    isUploading = false
                    uploadStatus = ""
                    uploadError = error.localizedDescription
                    showAlert = true
                    print("Lỗi: \(error.localizedDescription)")
                }
            }
        }
    }
    // Hàm crop ảnh chính xác theo khung preview
    private func cropImageToRect(image: UIImage, previewSize: CGSize, cropRect: CGRect) -> UIImage {
        // Normalize image orientation trước
        guard let normalizedImage = image.fixOrientation() else { return image }
        guard let cgImage = normalizedImage.cgImage else { return image }
        
        let imageWidth = CGFloat(cgImage.width)
        let imageHeight = CGFloat(cgImage.height)
        let imageAspect = imageWidth / imageHeight
        let previewAspect = previewSize.width / previewSize.height
        
        // Tính vùng ảnh hiển thị trong preview (resizeAspectFill)
        var scale: CGFloat
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        
        if imageAspect > previewAspect {
            // Ảnh rộng hơn - fit by height
            scale = imageHeight / previewSize.height
            let visibleWidth = previewSize.width * scale
            offsetX = (imageWidth - visibleWidth) / 2
        } else {
            // Ảnh cao hơn - fit by width
            scale = imageWidth / previewSize.width
            let visibleHeight = previewSize.height * scale
            offsetY = (imageHeight - visibleHeight) / 2
        }
        
        // Convert crop rect từ preview coordinates sang image coordinates
        let imageCropRect = CGRect(
            x: offsetX + cropRect.origin.x * scale,
            y: offsetY + cropRect.origin.y * scale,
            width: cropRect.width * scale,
            height: cropRect.height * scale
        )
        
        guard let croppedCGImage = cgImage.cropping(to: imageCropRect) else {
            return normalizedImage
        }
        
        return UIImage(cgImage: croppedCGImage)
    }
} // <-- Inserted closing brace to end struct CameraView

// Extension để fix orientation
extension UIImage {
    func fixOrientation() -> UIImage? {
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}


#Preview {
    CameraView()
}
