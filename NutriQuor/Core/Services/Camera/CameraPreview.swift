//
//  CameraPreview.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraService
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: .zero)
        view.backgroundColor = .black
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: camera.session)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = .portrait
        
        view.layer.addSublayer(previewLayer)
        
        context.coordinator.previewLayer = previewLayer
        
        // Lưu preview layer vào camera service
        DispatchQueue.main.async {
            self.camera.previewLayer = previewLayer
        }
        
        // Update frame after a short delay to ensure view has proper bounds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            previewLayer.frame = view.bounds
            print("📐 Preview layer frame: \(view.bounds)")
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
        DispatchQueue.main.async {
            if let previewLayer = context.coordinator.previewLayer {
                previewLayer.frame = uiView.bounds
                print("🔄 Updated preview layer frame: \(uiView.bounds)")
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator {
        var previewLayer: AVCaptureVideoPreviewLayer?
    }
}
