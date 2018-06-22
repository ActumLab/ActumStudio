//
//  CameraManager.swift
//  SiemensAR
//
//  Created by Rafał Sowa on 12/04/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import ARKit
import AVFoundation
import UIKit

class CameraMaanger {
    
    func openViewControllerWithCameraUsage(from view: UIViewController?, action: @escaping () -> ()) {
        isPerrmissionToUseCamera { [weak self] granted in
            if granted {
                DispatchQueue.main.async {
                    action()
                }
            } else {
                self?.showSettingsAlert(in: view)
            }
        }
    }
    
}

private extension CameraMaanger {
    func showSettingsAlert(in view: UIViewController?) {
        let alert = UIAlertController(title: "Error", message: "This app is not authorized to use Camera.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Settings", style: .default, handler: { (_) in
            DispatchQueue.main.async {
                if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
//        let appDelegate = AppDelegate()
//        appDelegate.window?.rootViewController?.present(alert, animated: true, completion: nil)
        view?.present(alert, animated: true, completion: nil)
    }
    
    func isPerrmissionToUseCamera(completion: @escaping (_ granted: Bool) ->()) {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { granted in
            completion(granted)
        });
    }
}
