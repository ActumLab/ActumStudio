//
//  UIViewController.swift
//  Extension
//
//  Created by Rafał Sowa on 22/03/2018.
//  Copyright © 2018 Rafał Sowa. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func add(child: UIViewController, isFullScreen: Bool) {
        addChildViewController(child)
        view.addSubview(child.view)
        child.didMove(toParentViewController: self)
        if isFullScreen {
            child.view.frame = view.frame
            child.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
    
    func add(child: UIViewController, isFullScreen: Bool, to superView: UIView) {
        addChildViewController(child)
        superView.addSubview(child.view)
        child.didMove(toParentViewController: self)
        if isFullScreen {
            child.view.translatesAutoresizingMaskIntoConstraints = false
            child.view.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
            child.view.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
            child.view.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
            child.view.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        }
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParentViewController: nil)
        removeFromParentViewController()
        view.removeFromSuperview()
    }
}
