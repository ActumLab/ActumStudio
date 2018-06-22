//
//  Texture.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

struct Texture: Codable {
    let id: Int
    
    let name: String
    
    let ambientOcclusion: String?
    
    let normal: String?
    
    let metalness: String?
    
    let diffuse: String?
    
    let roughness: String?
    
    let scale: Float?
    
    let inensity: Float?
    
    let materialName: String
    
    enum CodingKeys: String, CodingKey
    {
        case id = "idtexture"
        case name
        case ambientOcclusion = "ambientOcclusion_url"
        case normal = "normal_url"
        case metalness = "metalness_url"
        case diffuse = "diffuse_url"
        case roughness = "roughness_url"
        case scale
        case inensity
        case materialName = "material"
    }
}
