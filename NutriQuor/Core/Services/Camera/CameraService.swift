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
            DispatchQueue.main.async {
                self.isAuthorized = true
            }
            sessionQueue.async { [weak self] in
                self?.configure()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                DispatchQueue.main.async {
                    self?.isAuthorized = granted
                }
                if granted {
                    self?.sessionQueue.async {
                        self?.configure()
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.alertError = "Vui lòng cấp quyền camera trong phần cài đặt."
                    }
                }
            }
        case .denied:
            DispatchQueue.main.async {
                self.alertError = "Quyền camera đang bị tắt. Vui lòng mở Cài đặt > NutriQuor > Camera để bật lại."
            }
        case .restricted:
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
        
        
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera,
                                                   for: .video,
                                                   position: .back) else {
            DispatchQueue.main.async {
                self.alertError = "Không tìm thấy camera"
            }
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                throw NSError(domain: "CameraService", code: -1)
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
            } else {
                throw NSError(domain: "CameraService", code: -2)
            }
            
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                self?.session.startRunning()
            }
        } catch {
            DispatchQueue.main.async {
                self.alertError = "Không thể khởi động camera. Vui lòng thử lại."
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
