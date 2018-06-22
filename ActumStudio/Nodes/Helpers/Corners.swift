//
//  Corners.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 01/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import SceneKit

struct Corners {
    
    typealias Corner = SCNVector3
    
    let front: (left: Corner, right: Corner)
    let back: (left: Corner, right: Corner)
    
    let topFront: (left: Corner, right: Corner)
    let topBack: (left: Corner, right: Corner)
    
    init(min: SCNVector3, max: SCNVector3) {
        let leftFront = SCNVector3Make(min.x, min.y, -min.z)
        let rightFront = SCNVector3Make(max.x, min.y, max.z)
        
        let leftBack = min
        let rightBack = SCNVector3Make(max.x, min.y, -max.z)
        
        let leftFrontTop = SCNVector3Make(min.x, max.y, -min.z)
        let rightFrontTop = SCNVector3Make(max.x, max.y, max.z)
        
        let leftBackTop = SCNVector3Make(min.x, max.y, min.z)
        let rightBackTop = SCNVector3Make(max.x, max.y, -max.z)
        
        front = (leftFront, rightFront)
        back = (leftBack, rightBack)
        
        topFront = (leftFrontTop, rightFrontTop)
        topBack = (leftBackTop, rightBackTop)
    }
}
