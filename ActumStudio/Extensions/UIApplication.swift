//
//  UIApplication.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

extension UIApplication{
    class func getPresentedViewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController {
            presentViewController = pVC
        }
        
        return presentViewController
    }
    
    class func getPresentedNavigationController() -> UINavigationController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController?.navigationController
        while let pVC = presentViewController?.navigationController {
            presentViewController = pVC
        }
        
        return presentViewController
    }
}
