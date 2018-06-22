//
//  ScenekitTestVC.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 01/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import SceneKit

class ScenekitTestVC: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    let scene = SCNScene()
    
    private let mainScale: Float = 0.001
    private let scaleDirectionArrows: Float = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.allowsCameraControl = true
        sceneView.autoenablesDefaultLighting = true
        sceneView.scene = scene
        
        let node = SCNScene(named: "Models.scnassets/dom2r.scn")!.rootNode.clone()

        let box = SCNBox(width: 1, height: 1, length: 1, chamferRadius: 0)
        box.firstMaterial?.lightingModel = .physicallyBased
        box.firstMaterial?.diffuse.contents = UIColor.blue
//        let node = SCNNode(geometry: box)
        
        for node in node.childNodes {
            node.geometry?.firstMaterial?.lightingModel = .physicallyBased
        }
        
        let originNodeSize = node.size
        let arrowsScale: Float = (originNodeSize.width + originNodeSize.length)/4
        
        let rotationArrowsNode = RotationArrowsNode(parentBoundingBox: node.boundingBox, scale: arrowsScale)
        let directionsArrowsNode = DirectionsArrowsNode(parentBoundingBox: node.boundingBox, scale: arrowsScale)
        
        node.addChildNode(rotationArrowsNode)
        node.addChildNode(directionsArrowsNode)
        node.scale = SCNVector3Make(mainScale, mainScale, mainScale)
        node.position = SCNVector3Make(0, 0, 0)
        
        scene.rootNode.addChildNode(node)
    }
}
