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
}
