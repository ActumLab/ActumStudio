//
//  RotationArrowsNode.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 04/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import SceneKit

class RotationArrowsNode: SCNNode {
    
    private var frontLeftArrow: SCNNode!
    private var backRightArrow: SCNNode!
    private let corners: Corners

    init(parentBoundingBox: (min: SCNVector3, max: SCNVector3), scale: Float) {
        corners = Corners(min: parentBoundingBox.min, max: parentBoundingBox.max)
        super.init()
        
        frontLeftArrow = arrow(name: "arrow1", withScale: SCNVector3Make(scale, scale, scale))
        frontLeftArrow.position = corners.front.left.midPointTo(vector: corners.topFront.left)
        
        backRightArrow = arrow(name: "arrow2", withScale: SCNVector3Make(scale, scale, scale))
        backRightArrow.position = corners.back.right.midPointTo(vector: corners.topBack.right)

        addChildNode(frontLeftArrow)
        addChildNode(backRightArrow)
        
        let anim = SCNAction.rotateBy(x: 0, y: CGFloat(Float.pi/16), z: 0, duration: 1)
        let animRev = anim.reversed()
        let action =  SCNAction.repeatForever(SCNAction.sequence([anim, animRev]))

        frontLeftArrow.runAction(action)
        backRightArrow.runAction(action)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func arrow(name: String, withScale scale: SCNVector3) -> SCNNode {
        let node = SCNScene(named: "Models.scnassets/Arrows/arrowsRotate.scn")!.rootNode.childNode(withName: name, recursively: true)!
        let initScale: Float = 0.04
        node.scale = SCNVector3Make(scale.x*initScale, scale.y*initScale, scale.z*initScale)
        return node
    }
}

