//
//  CameraView.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI

struct CameraView: View {
    
    @StateObject private var camera = CameraService()
    @State private var croppedImage: UIImage?
    @State private var cutoutRect: CGRect = .zero
    @State private var showImagePreview = false
    @State private var showPhotoLibrary = false
    @Environment(\.dismiss) var dismiss
    var onAnalysisComplete: (Product) -> Void = { _ in }
    
    let frameHeight: CGFloat = 550
    let horizontalPadding: CGFloat = 20
    
    var body: some View {
        NavigationStack {
            ZStack {
            
                if camera.isAuthorized {
                    CameraPreview(camera: camera)
                        .ignoresSafeArea()
                        .onChange(of: camera.photo) { oldValue, newValue in
                            if let photo = newValue {
                                cropImageToFrame(photo, cutoutRect: cutoutRect)
                            }
                        }
                } else {
                    Color.black
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        Image(systemName: "camera.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.white)
                        
                        Text(camera.alertError ?? "Đang yêu cầu quyền camera...")
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                        if camera.alertError != nil {
                            Button("Mở Settings") {
                                if let url = URL(string: UIApplication.openSettingsURLString) {
                                    UIApplication.shared.open(url)
                                }
                            }
                            .padding()
                            .background(Color("ColorPrimary"))
                            .foregroundColor(.white)
                            .cornerRadius(.smallRadius)
                        }
                    }
                }
            
                GeometryReader { geo in
                    
                    let calculatedCutout = CGRect(
                        x: horizontalPadding,
                        y: (geo.size.height - frameHeight) / 2,
                        width: geo.size.width - horizontalPadding * 2,
                        height: frameHeight
                    )
                    
                    ZStack {
                        
                        // Overlay tối
                        Color.black.opacity(.opacityMedium)
                            .mask(
                                Path { path in
                                    
                                    path.addRect(CGRect(origin: .zero, size: geo.size))
                                    
                                    path.addRoundedRect(
                                        in: calculatedCutout,
                                        cornerSize: CGSize(width: 20, height: 20)
                                    )
                                }
                                .fill(style: FillStyle(eoFill: true))
                            )
                        
                        // Scan frame
                        CameraFrame(frameHeight: frameHeight)
                            .frame(width: calculatedCutout.width, height: calculatedCutout.height)
                            .position(
                                x: calculatedCutout.midX,
                                y: calculatedCutout.midY
                            )
                    }
                    .onAppear {
                        cutoutRect = calculatedCutout
                    }
                    .onChange(of: geo.size) { oldValue, newValue in
                        cutoutRect = calculatedCutout
                    }
                }
                .ignoresSafeArea()
            
                VStack {
                    
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
                        
                        Color.clear
                            .frame(width: 44, height: 44)
                    }
                    .padding()
                    .background(Color.black.opacity(.opacityStrong))
                    
                    
                    Spacer()
                    
                    BottomControlCamera(onPickImage: {
                        showPhotoLibrary = true
                    }, onCapture: {
                        camera.takePhoto()
                    })
                    .padding(.horizontal, 70)
                }
            }
            .sheet(isPresented: $showPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    croppedImage = image.fixedOrientation()
                    showImagePreview = true
                }
            }
            .navigationDestination(isPresented: $showImagePreview) {
                if let cropped = croppedImage {
                    ImagePreviewView(
                        croppedImage: cropped,
                        onAnalysisComplete: onAnalysisComplete
                    )
                }
            }
        }
    }
    
    private func cropImageToFrame(_ image: UIImage, cutoutRect: CGRect) {
        // Normalize image orientation trước khi crop
        let normalizedImage = image.fixedOrientation()
        
        guard let cgImage = normalizedImage.cgImage else { return }
        
        print("🖼️ Original image size: \(image.size), orientation: \(image.imageOrientation.rawValue)")
        print("🔄 Normalized image size: \(normalizedImage.size)")
        print("📏 Cutout rect: \(cutoutRect)")
        
        // Lấy kích thước ảnh gốc
        let imageWidth = CGFloat(cgImage.width)
        let imageHeight = CGFloat(cgImage.height)
        
        print("📷 CGImage size: \(imageWidth) x \(imageHeight)")
        
        // Lấy kích thước màn hình
        let screenSize = UIScreen.main.bounds.size
        print("📱 Screen size: \(screenSize)")
        
        // Tính tỷ lệ aspect fill - ảnh được scale để fill màn hình
        let imageAspect = imageWidth / imageHeight
        let screenAspect = screenSize.width / screenSize.height
        
        var scale: CGFloat
        var offsetX: CGFloat = 0
        var offsetY: CGFloat = 0
        
        if imageAspect > screenAspect {
            // Ảnh rộng hơn màn hình - scale theo chiều cao
            scale = imageHeight / screenSize.height
            let scaledWidth = imageWidth / scale
            offsetX = (scaledWidth - screenSize.width) / 2 * scale
        } else {
            // Ảnh cao hơn màn hình - scale theo chiều rộng
            scale = imageWidth / screenSize.width
            let scaledHeight = imageHeight / scale
            offsetY = (scaledHeight - screenSize.height) / 2 * scale
        }
        
        print("📐 Scale: \(scale), Offset: (\(offsetX), \(offsetY))")
        
        // Chuyển đổi cutout rect sang tọa độ ảnh
        let cropRect = CGRect(
            x: (cutoutRect.origin.x * scale) + offsetX,
            y: (cutoutRect.origin.y * scale) + offsetY,
            width: cutoutRect.width * scale,
            height: cutoutRect.height * scale
        )
        
        print("✂️ Crop rect in image space: \(cropRect)")
        
        // Đảm bảo crop rect nằm trong bounds của ảnh
        let finalCropRect = CGRect(
            x: max(0, min(cropRect.origin.x, imageWidth - 1)),
            y: max(0, min(cropRect.origin.y, imageHeight - 1)),
            width: min(cropRect.width, imageWidth - cropRect.origin.x),
            height: min(cropRect.height, imageHeight - cropRect.origin.y)
        )
        
        print("✅ Final crop rect: \(finalCropRect)")
        
        // Crop ảnh
        if let croppedCGImage = cgImage.cropping(to: finalCropRect) {
            self.croppedImage = UIImage(cgImage: croppedCGImage)
            print("✅ Ảnh đã được crop: \(croppedImage?.size ?? .zero)")
            
            // Chuyển sang trang xem ảnh
            showImagePreview = true
        } else {
            print("❌ Không thể crop ảnh")
        }
    }
}


#Preview {
    CameraView()
}
