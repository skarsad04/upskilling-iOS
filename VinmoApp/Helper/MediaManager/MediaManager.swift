//
//  MediaManager.swift
//  VinmoApp
//
//  Created by asif hussain on 3/17/23.
//

import Foundation
import UIKit
import Photos

protocol MediaSelectedDelegate: AnyObject {
    func selectedMediaType(image: UIImage)
    func permissionDenied()
}

class MediaManager: NSObject{
    private let imagePicker = UIImagePickerController()
    var allowsEditing: Bool = false
    var delegate: MediaSelectedDelegate?
    static let shared = MediaManager()
    override init(){}
    func showMediaSheetOn(_ viewController: UIViewController, allowsEditing: Bool = true) {
        imagePicker.allowsEditing = allowsEditing
        self.allowsEditing = allowsEditing
        
        let alert = UIAlertController(title: "Choose Image", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {(action: UIAlertAction) in
            self.capturePhotoFromCamera(viewController)
        }))
        alert.addAction(UIAlertAction(title: "Photo Album", style: .default, handler: {(action: UIAlertAction) in
            self.capturePhotoFromLibrary(viewController)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
    private func capturePhotoFromCamera(_ viewController: UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
                showCamera(viewController)
            } else if AVCaptureDevice.authorizationStatus(for: .video) ==  .denied || AVCaptureDevice.authorizationStatus(for: .video) ==  .restricted{
                delegate?.permissionDenied()
            }else {
                AVCaptureDevice.requestAccess(for: .video, completionHandler: { [weak self](granted: Bool) in
                    if granted {
                        //access allowed
                        DispatchQueue.main.async {
                            self?.showCamera(viewController)
                        }
                    } else {
                    }
                })
            }
            
        }else{
           
        }
        
        
    }
    private func showCamera(_ viewController: UIViewController){
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        viewController.present(imagePicker, animated: true, completion: nil)
    }
    private func capturePhotoFromLibrary(_ viewController:  UIViewController){
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        viewController.present(imagePicker, animated: true, completion: nil)
    }
}
extension MediaManager : UINavigationControllerDelegate{
    
}

extension MediaManager : UIImagePickerControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true) {
            let key = self.allowsEditing ? UIImagePickerController.InfoKey.editedImage: UIImagePickerController.InfoKey.originalImage
            if let image = info[key] as? UIImage {
                self.delegate?.selectedMediaType(image: image)
            }
            
        }
        
    }
}
