//
//  NodeData.swift
//  Mikomax
//
//  Created by BARTOSZ ROZWARSKI on 17/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation

struct NodeData: ListItem {
    
    var isSelected: Bool = false
    var materials: [MaterialData]
    let name: String
    let image: String
    let displayName: String
    
    init(named name: String, materials: [MaterialData], image: String, displayName: String) {
        self.name = name
        self.materials = materials
        self.image = image
        self.displayName = displayName
    }
}
