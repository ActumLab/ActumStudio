//
//  TexturesLoader.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 29/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import SceneKit

protocol TexturesLoading {
    func load(textures: [Texture], isPBR: Bool)
}

class TexturesLoader {
    
    let modelToTexturing: SCNNode
    
    init(modelToTexturing: SCNNode) {
        self.modelToTexturing = modelToTexturing
    }
    
    private func setup(materialProperty: SCNMaterialProperty?, with textureUrlString: String?, isMirror: Bool = false) {
        guard let fileTexture = textureUrlString?.url()?.lastPathComponent else {
            return
        }
        
        materialProperty?.contents = getPhoto(name: fileTexture)
        if isMirror {
            materialProperty?.contentsTransform = getMirrorReflection()
        }
    }
    
    private func getMirrorReflection() -> SCNMatrix4 {
        return SCNMatrix4MakeScale(1,-1,1);
    }
    
    private func getPhoto(name: String?) -> UIImage?{
        guard let name = name else { return nil}
        
        let url =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent(name)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            print("File: \(name) not exist")
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            print("Cannot create data from url: \(url)    Name: \(name)")
            return nil
        }
        
        guard let image = UIImage(data: data) else {
            print("File name \(name) Cannot create image from data")
            return nil
        }
        
        return image
    }
}

extension TexturesLoader: TexturesLoading {
    func load(textures: [Texture], isPBR: Bool) {
        for texture in textures {
            if isPBR {
                modelToTexturing.geometry?.material(named: texture.materialName)?.lightingModel = .physicallyBased
            }

            setup(materialProperty: modelToTexturing.geometry?.material(named: texture.materialName)?.diffuse, with: texture.diffuse)
            setup(materialProperty: modelToTexturing.geometry?.material(named: texture.materialName)?.roughness, with: texture.roughness, isMirror: true)
            setup(materialProperty: modelToTexturing.geometry?.material(named: texture.materialName)?.ambientOcclusion, with: texture.ambientOcclusion, isMirror: true)
            setup(materialProperty: modelToTexturing.geometry?.material(named: texture.materialName)?.normal, with: texture.normal, isMirror: true)
            setup(materialProperty: modelToTexturing.geometry?.material(named: texture.materialName)?.metalness, with: texture.metalness, isMirror: true)
            
            if let scale = texture.scale {
                modelToTexturing.geometry?.material(named: texture.materialName)?.diffuse.contentsTransform = SCNMatrix4MakeScale(scale, scale, 0)
                modelToTexturing.geometry?.material(named: texture.materialName)?.roughness.contentsTransform = SCNMatrix4MakeScale(scale, scale, 0)
                modelToTexturing.geometry?.material(named: texture.materialName)?.ambientOcclusion.contentsTransform = SCNMatrix4MakeScale(scale, scale, 0)
                modelToTexturing.geometry?.material(named: texture.materialName)?.normal.contentsTransform = SCNMatrix4MakeScale(scale, scale, 0)
                modelToTexturing.geometry?.material(named: texture.materialName)?.metalness.contentsTransform = SCNMatrix4MakeScale(scale, scale, 0)
                
            }
            
            if let intensity = texture.inensity {
                modelToTexturing.geometry?.material(named: texture.materialName)?.diffuse.intensity = CGFloat(intensity)
                modelToTexturing.geometry?.material(named: texture.materialName)?.roughness.intensity = CGFloat(intensity)
                modelToTexturing.geometry?.material(named: texture.materialName)?.ambientOcclusion.intensity = CGFloat(intensity)
                modelToTexturing.geometry?.material(named: texture.materialName)?.normal.intensity = CGFloat(intensity)
                modelToTexturing.geometry?.material(named: texture.materialName)?.metalness.intensity = CGFloat(intensity)
                
            }
        }
    }
}
