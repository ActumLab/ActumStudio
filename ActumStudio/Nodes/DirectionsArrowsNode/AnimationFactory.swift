//
//  AnimationFactory.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 01/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import SceneKit

protocol AnimationFactoryProtocol {
    func animationFor(direction: AnimationFactory.Direction) -> SCNAction
}

struct AnimationFactory {
    
    // MARK: - Public
    
    enum Direction {
        case front
        case back
        case left
        case right
    }
    
    // MARK: - Private
    
    private let centers: Centers
    private enum Axis{
        case x
        case z
    }
    // MARK: - Init
    
    init(centers: Centers) {
        self.centers = centers
    }
    
    private func createAnimationFor(center: SCNVector3, alongside axis: Axis) -> SCNAction {
        switch axis {
        case .x:
            let anim = SCNAction.move(to: SCNVector3Make(center.x + center.x/4, center.y, center.z), duration: 1)
            let animRev = SCNAction.move(to: center, duration: 1)
            return  SCNAction.repeatForever(SCNAction.sequence([anim, animRev]))
            
        case .z:
            let anim = SCNAction.move(to: SCNVector3Make(center.x, center.y, center.z + center.z/4), duration: 1)
            let animRev = SCNAction.move(to: center, duration: 1)
            return SCNAction.repeatForever(SCNAction.sequence([anim, animRev]))
        }
    }
}

extension AnimationFactory: AnimationFactoryProtocol {
    func animationFor(direction: AnimationFactory.Direction) -> SCNAction {
        
        switch direction {
        case .front:
            return createAnimationFor(center: centers.front, alongside: .z)
            
        case .back:
            return createAnimationFor(center: centers.back, alongside: .z)
            
        case .left:
            return createAnimationFor(center: centers.left, alongside: .x)

        case .right:
            return createAnimationFor(center: centers.right, alongside: .x)
        }
    }
}
