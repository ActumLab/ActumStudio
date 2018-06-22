//
//  SCNNode.swift
//  Extension
//
//  Created by Rafał Sowa on 22/03/2018.
//  Copyright © 2018 Rafał Sowa. All rights reserved.
//

import SceneKit.ModelIO

extension SCNNode {
    
    var size: (width: Float, height: Float, length: Float) {
        get {
            let min = self.boundingBox.min
            let max = self.boundingBox.max
            
            let width = Float(max.x - min.x)
            let height = Float(max.y - min.y)
            let length = Float( max.z - min.z)
            
            return (width, height, length)
        }
    }
    
    convenience init?(urlToObj: URL) {
        let asset = MDLAsset(url: urlToObj)
        
        guard let objectLocal = asset.object(at: 0) as? MDLMesh else {
            return nil
        }
        
        self.init(mdlObject: objectLocal)
    }
}

