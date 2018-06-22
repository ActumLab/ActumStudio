//
//  ModelAR.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation

struct ModelAR: Codable {
    let id: Int
    
    var displayName: String
    
    var scale: Float
    
    var objFile: String
    
    var mtlFile: String
    
    var pbr: Int
    
    var textures: [Texture]
    
    var isPBR: Bool {
        return pbr == 1
    }
    
    init(id: Int, displayName: String, scale: Float, objFile: String, mtlFile: String, pbr: Int, textures: [Texture]) {
        self.id = id
        self.displayName = displayName
        self.scale = scale
        self.objFile = objFile
        self.mtlFile = mtlFile
        self.pbr = pbr
        self.textures = textures
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id = "idarmodel"
        case displayName
        case scale
        case objFile = "obj_url"
        case mtlFile = "mtl_url"
        case pbr = "pbr"
        case textures
    }
}
