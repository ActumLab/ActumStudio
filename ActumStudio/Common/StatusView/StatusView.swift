//
//  DetectionAlertView.swift
//  Spatial Measure Kit
//
//  Created by Rafał Sowa on 16/04/2018.
//  Copyright © 2018 ActumLab. All rights reserved.
//

import Foundation
import UIKit


import ARKit

protocol StatusViewInteractionable {
    ///Show status with `String` message
    func show(with message: String)
    ///Show status with `Message`
    func show(message: Message)
    ///Hide status with optional delay
    func hide(isAnimated: Bool, withDelay delay: TimeInterval?)
}

class StatusView: NibView {
    
    // MARK: - Outlets
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    // MARK: - Private
    private var messageHideTimer: Timer?

    // MARK: - Public
    
    /// Trigerred when the "Restart" button is tapped.
    var restartHandler: () -> () = { }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func restart(_ sender: Any) {
        restartHandler()
    }
}

extension StatusView: StatusViewInteractionable {
    func show(with message: String) {
        textLabel.text = message
        if !self.transform.isIdentity {
            show(duration: 0.5, delay: 0)
        }
    }
    
    func show(message: Message) {
        messageHideTimer?.invalidate()
        messageHideTimer = nil
        
        restartButton.isHidden = !message.buttonIsNeeded
        show(with: message.description)
    }
    
    func hide(isAnimated: Bool, withDelay delay: TimeInterval? = nil) {
        guard let delay = delay else {
            hide(duration: isAnimated ? 0.5 : 0, delay: 0)
            return
        }
        
        messageHideTimer?.invalidate()
        messageHideTimer = nil
        messageHideTimer = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { [weak self] (timer) in
            self?.hide(duration: isAnimated ? 0.5 : 0, delay: 0)
        }
        
    }
}

private extension StatusView {
    func show(duration: TimeInterval, delay: TimeInterval) {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: { [weak self] in
            self?.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func hide(duration: TimeInterval, delay: TimeInterval)  {
        UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: { [weak self] in
            self?.transform = CGAffineTransform(translationX: 250, y: 0)
        }, completion:  nil)
    }
}
