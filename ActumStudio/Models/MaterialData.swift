//
//  MaterialData.swift
//  Mikomax
//
//  Created by BARTOSZ ROZWARSKI on 17/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation

struct MaterialData: ListItem, Decodable {
    
    var isSelected: Bool = false
    let name: String
    let image: String
    
    init(name: String, image: String) {
        self.image = image
        self.name = name
    }
    
    public enum CodingKeys: String, CodingKey {
        case name
        case image
    }
    
    func getPathForTexture() -> String{
        return AppConfig.modelsAssetsPath + image
    }
}
