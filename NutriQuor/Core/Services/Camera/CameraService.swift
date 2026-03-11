//
//  CameraService.swift
//  NutriQuor
//
//  Created by Lâm Tấn Thành on 10/3/26.
//

import AVFoundation
import SwiftUI
import Combine

class CameraService: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    
    let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    private let sessionQueue = DispatchQueue(label: "camera.session.queue")
    
    @Published var photo: UIImage?
    @Published var isAuthorized = false
    @Published var alertError: String?
    @Published var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init() {
        super.init()
        checkPermissions()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            print("✅ Camera authorized")
            DispatchQueue.main.async {
                self.isAuthorized = true
            }
            sessionQueue.async { [weak self] in
                self?.configure()
            }
        case .notDetermined:
            print("⏳ Requesting camera permission...")
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                print("Camera permission: \(granted ? "✅ Granted" : "❌ Denied")")
                DispatchQueue.main.async {
                    self?.isAuthorized = granted
                }
                if granted {
                    self?.sessionQueue.async {
                        self?.configure()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.alertError = "Vui lòng cấp quyền camera trong Settings"
                    }
                }
            }
        case .denied:
            print("❌ Camera access denied")
            DispatchQueue.main.async {
                self.alertError = "Camera bị từ chối. Vào Settings > NutriQuor > Camera để bật"
            }
        case .restricted:
            print("⚠️ Camera access restricted")
            DispatchQueue.main.async {
                self.alertError = "Camera bị hạn chế bởi chính sách thiết bị"
            }
        @unknown default:
            break
        }
    }
    
    func configure() {
        session.beginConfiguration()
        session.sessionPreset = .photo
        
        print("🎥 Configuring camera...")
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .back) else {
            print("❌ No camera device found")
            DispatchQueue.main.async {
                self.alertError = "Không tìm thấy camera"
            }
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            if session.canAddInput(input) {
                session.addInput(input)
                print("✅ Camera input added")
            } else {
                print("❌ Cannot add camera input")
                throw NSError(domain: "CameraService", code: -1, userInfo: [NSLocalizedDescriptionKey: "Cannot add input"])
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
                print("✅ Camera output added")
            } else {
                print("❌ Cannot add camera output")
                throw NSError(domain: "CameraService", code: -2, userInfo: [NSLocalizedDescriptionKey: "Cannot add output"])
            }
            
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.startRunning()
                print("✅ Camera session started")
            }
        } catch {
            print("❌ Camera configuration error: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.alertError = "Lỗi cấu hình camera: \(error.localizedDescription)"
            }
        }
    }
    
    func takePhoto() {
        sessionQueue.async { [weak self] in
            guard let self = self else { return }
            let settings = AVCapturePhotoSettings()
            self.output.capturePhoto(with: settings, delegate: self)
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput,
                     didFinishProcessingPhoto photo: AVCapturePhoto,
                     error: Error?) {
        
        guard let data = photo.fileDataRepresentation(),
              let image = UIImage(data: data)
        else { return }
        
        DispatchQueue.main.async {
            self.photo = image
        }
    }
}
