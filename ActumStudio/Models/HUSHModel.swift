//
//  ModelName.swift
//  Mikomax
//
//  Created by Rafał Sowa on 11/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import UIKit

enum HUSHModel: Int {
    case phone = 32
    case meet = 31
    case work = 33
    
    var fileName: String {
        switch self {
        case .phone:
            return "Models.scnassets/Phone/phone.scn"
        case .meet:
            return "Models.scnassets/Meet/008-anim.scn"
        case .work:
            return "Models.scnassets/SCN/work.scn"
        }
    }

    var textilesMaterialsData: [MaterialData] {
        let url = Bundle.main.url(forResource: "Materials", withExtension: "json")
        let data = try! Data(contentsOf: url!)
        let materialsData = try! JSONDecoder().decode([MaterialData].self, from: data)
        return materialsData
    }
    
    var cabineMaterialsData: [MaterialData] {
        let whiteMaterial = MaterialData(name: "White", image: "kabina2Diffuse.jpg")
        let darkMaterial = MaterialData(name: "Dark", image: "kabinaDiffuse.jpg")
        return [whiteMaterial, darkMaterial]
    }
    
    
    var childNodes: [NodeData] {
        switch self {
        case .phone:
            let interiorNode = NodeData(named: "tekstura1", materials: self.textilesMaterialsData, image: "textiles", displayName: "Interior")
            let externalCoverNode = NodeData(named: "kabina-Pivot", materials: self.cabineMaterialsData, image: "externalCover", displayName: "Hull")
            return [interiorNode, externalCoverNode]
        case .meet:
            let interiorNode = NodeData(named: "obiciaWnetrz", materials: self.textilesMaterialsData, image: "textiles", displayName: "Interior")
            let externalCoverNode = NodeData(named: "kabina-Pivot", materials: self.cabineMaterialsData, image: "externalCover", displayName: "Hull")
            return [interiorNode, externalCoverNode]
        case .work:
            let interiorNode = NodeData(named: "obiciaWnetrz1-Pivot", materials: self.textilesMaterialsData, image: "textiles", displayName: "Interior")
            let externalCoverNode = NodeData(named: "kabina-Pivot", materials: self.cabineMaterialsData, image: "externalCover", displayName: "Hull")
            return [interiorNode, externalCoverNode]
        }
    }

    init?(id: Int) {
        self.init(rawValue: id)
    }

}
