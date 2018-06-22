//
//  Centers.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 01/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import SceneKit

struct Centers {
    
    let left: SCNVector3
    let right: SCNVector3
    let front: SCNVector3
    let back: SCNVector3
    
    let all: [SCNVector3]
    
    init(min: SCNVector3, max: SCNVector3) {
        let corners = Corners(min: min, max: max)
        
        left = corners.front.left.midPointTo(vector: corners.back.left)
        right = corners.front.right.midPointTo(vector: corners.back.right)
        
        front = corners.front.left.midPointTo(vector: corners.front.right)
        back = corners.back.left.midPointTo(vector: corners.back.right)
        
        all = [left, right, front, back]
    }
}


extension SCNVector3 {
    func midPointTo(vector: SCNVector3) -> SCNVector3{
        return SCNVector3Make((self.x + vector.x)/2, (self.y + vector.y)/2, (self.z + vector.z)/2)
    }
}
