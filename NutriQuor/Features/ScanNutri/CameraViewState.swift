//
//  CameraViewState.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 24/1/26.
//

import SwiftUI
import PhotosUI
import Combine

/// State management cho CameraView
class CameraViewState: ObservableObject {
    @Published var capturedImage: UIImage?
    @Published var cropRect: CGRect = .zero
    @Published var previewSize: CGSize = .zero
    @Published var isUploading = false
    @Published var uploadError: String?
    @Published var showAlert = false
    @Published var ocrResult: OCRData?
    @Published var showOCRResult = false
    @Published var uploadStatus = ""
    @Published var selectedPhotoItem: PhotosPickerItem?
    
    func reset() {
        capturedImage = nil
        uploadStatus = ""
        uploadError = nil
    }
    
    func updateCropRect(width: CGFloat, height: CGFloat, in geometry: CGSize) {
        cropRect = CGRect(
            x: (geometry.width - width) / 2,
            y: (geometry.height - height) / 2,
            width: width,
            height: height
        )
        previewSize = geometry
    }
}
