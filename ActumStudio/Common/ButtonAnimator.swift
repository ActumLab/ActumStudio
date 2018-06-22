//
//  ButtonAnimator.swift
//  ActumStudio Prod
//
//  Created by Rafał Sowa on 06/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import UIKit

class ButtonAnimator {
    enum Direction {
        case top
        case left
        case right
        case bottom
    }
    
    private let frameView: CGRect
    
    init(frameView: CGRect) {
        self.frameView = frameView
    }
    
    func show(button: UIButton, duration: TimeInterval? = nil) {
        UIViewPropertyAnimator(duration: duration ?? 0.5, dampingRatio: 0.5) {
            button.transform = .identity
            }.startAnimation()
    }
    
    func hide(button: UIButton, inDirection direction: Direction, duration: TimeInterval? = nil) {
        guard button.transform == .identity else {
            return
        }
        
        let shiftPoint = calculateShift(for: button, inDirection: direction)
        
        UIViewPropertyAnimator(duration: duration ?? 0.5, dampingRatio: 0.5) {
            button.transform = CGAffineTransform(translationX: shiftPoint.x, y: shiftPoint.y)
            }.startAnimation()
    }
    
    private func calculateShift(for button: UIButton, inDirection direction: Direction) -> CGPoint {
        var shift: CGPoint = CGPoint(x: 0, y: 0)
        
        switch direction {
        case .top:
            shift = CGPoint(x: 0, y: 0)
            
        case .left:
            shift = CGPoint(x: -(frameView.minX + button.frame.width*2), y: 0)
            
        case .right:
            shift = CGPoint(x: 0, y: 0)
            
        case .bottom:
            shift = CGPoint(x: 0, y: frameView.minY + button.frame.height*2)
        }
        
        return shift
    }
    
}
