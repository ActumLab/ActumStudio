//
//  ARVC.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import AwesomeAR
import ARKit

class ARLayerVC: ARViewController {
    
    // MARK: - Public
    
    var loadModel: (() -> ModelAR?)?
    private var userIsInsideModel: Bool = false
    private lazy var anim: SCNAction = {
        let up = SCNAction.moveBy(x: 0, y: 0.1, z: 0, duration: 1)
        let down = up.reversed()
        let seq = SCNAction.sequence([up, down])
        
        return SCNAction.repeatForever(seq)
    }()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
    }
}

extension ARLayerVC: ARViewControllerDataSource {
    func loadModel3D(completion: @escaping (Object3D) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let object3D = Object3D()
            
            guard let loadModel = self?.loadModel, let model = loadModel() else {
                return
            }
            
            guard let objFileUrl = model.objFile.url() else {
                return
            }
            
            let url =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(objFileUrl.lastPathComponent)
            
            guard let node = SCNNode(urlToObj: url) else {
                return
            }
            
            let texturesLoader = TexturesLoader(modelToTexturing: node)
            texturesLoader.load(textures: model.textures, isPBR: model.isPBR)
            
            object3D.addChildNode(node)
            
            
            let mainScale: Float = model.scale
            
            let originNodeSize = object3D.size
            let arrowsScale: Float = (originNodeSize.width + originNodeSize.length)/4
            
            let rotationArrowsNode = RotationArrowsNode(parentBoundingBox: node.boundingBox, scale: arrowsScale)
            let directionsArrowsNode = DirectionsArrowsNode(parentBoundingBox: node.boundingBox, scale: arrowsScale)
            rotationArrowsNode.name = "rot"
            directionsArrowsNode.name = "dir"
            
            object3D.addChildNode(rotationArrowsNode)
            object3D.addChildNode(directionsArrowsNode)
            object3D.scale = SCNVector3Make(mainScale, mainScale, mainScale)
            
            completion(object3D)
        }
    }
}


