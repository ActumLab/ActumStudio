//
//  ArrowsNode.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 01/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import SceneKit

class DirectionsArrowsNode: SCNNode {
    
    // MARK: - Private
    
    private let leftArrow: SCNNode
    private let rightArrow: SCNNode
    private let backArrow: SCNNode
    private let frontArrow: SCNNode

    // MARK: - Init
    
    init(parentBoundingBox: (min: SCNVector3, max: SCNVector3), scale: Float) {
        let centers = Centers(min: parentBoundingBox.min, max: parentBoundingBox.max)
        let animationFactory = AnimationFactory(centers: centers)
        
        let baseArrow: SCNNode = SCNScene(named: "Models.scnassets/Arrows/arrowMove.scn")!.rootNode
        baseArrow.scale = SCNVector3Make(scale, scale, scale)
        
        leftArrow = baseArrow.clone()
        leftArrow.position = centers.left
        leftArrow.eulerAngles = SCNVector3Make(0, -Float.pi/2, 0)
        
        rightArrow =  baseArrow.clone()
        rightArrow.position = centers.right
        rightArrow.eulerAngles = SCNVector3Make(0, Float.pi/2, 0)
        
        backArrow = baseArrow.clone()
        backArrow.position = centers.back
        backArrow.eulerAngles = SCNVector3Make(0, Float.pi, 0)

        frontArrow = baseArrow.clone()
        frontArrow.position = centers.front

        super.init()
        
        addChildNode(leftArrow)
        addChildNode(rightArrow)
        addChildNode(backArrow)
        addChildNode(frontArrow)

        frontArrow.runAction(animationFactory.animationFor(direction: .front))
        backArrow.runAction(animationFactory.animationFor(direction: .back))
        leftArrow.runAction(animationFactory.animationFor(direction: .left))
        rightArrow.runAction(animationFactory.animationFor(direction: .right))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
