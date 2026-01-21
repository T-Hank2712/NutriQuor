//
//  CameraViewModel.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 14/1/26.
//

import AVFoundation
import SwiftUI
import Combine


class CameraViewModel: NSObject, ObservableObject {
    @Published var images: [UIImage] = []

    let session = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private var isConfigured = false
    private var latestBuffer: CVPixelBuffer?

    override init() {
        super.init()
    }

    private func setupSession() {
        guard !isConfigured else { return }
        
        checkPermissions()
        
        session.beginConfiguration()
        session.sessionPreset = .photo

        session.inputs.forEach { session.removeInput($0) }
        session.outputs.forEach { session.removeOutput($0) }

        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                    for: .video,
                                                    position: .back) else {
            print("❌ Không tìm thấy camera")
            session.commitConfiguration()
            return
        }

        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print("❌ Lỗi tạo camera input: \(error)")
            session.commitConfiguration()
            return
        }

        // Sử dụng video output để capture nhanh hơn
        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA]
        
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
        }

        session.commitConfiguration()
        isConfigured = true
        print("✅ Camera session đã được setup")
    }
    
    private func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("✅ Đã có quyền camera")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                print(granted ? "✅ Đã cấp quyền camera" : "❌ Từ chối quyền camera")
            }
        default:
            print("⚠️ Chưa có quyền camera")
        }
    }

    func startSession() {
        setupSession()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if !self.session.isRunning {
                self.session.startRunning()
                print("▶️ Camera session started")
            }
        }
    }

    func stopSession() {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            if self.session.isRunning {
                self.session.stopRunning()
                print("⏸️ Camera session stopped")
            }
        }
    }

    func capturePhoto() {
        guard images.isEmpty, let buffer = latestBuffer else { return }

        // Haptic feedback ngay lập tức
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        // Convert buffer thành UIImage
        let ciImage = CIImage(cvPixelBuffer: buffer)
        let context = CIContext()
        
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return }
        let image = UIImage(cgImage: cgImage, scale: 1.0, orientation: .right)
        
        DispatchQueue.main.async {
            self.images.append(image)
        }
    }
}

extension CameraViewModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        latestBuffer = pixelBuffer
    }
}

