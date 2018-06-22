//
//  Product.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

/// Model describes Product in app
import Foundation

struct Product: Codable {
    let idproduct: Int?
    let title: String?
    let description: String?
    let link: String?
    let price: Int?
    let photoUrlString: String?
    let phone: String?
    let address: String?
    let galleryCount: Int?
    let the3DmodelCount: Int?
    let toursCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case idproduct = "idproduct"
        case title = "title"
        case description = "description"
        case link = "link"
        case price = "price"
        case photoUrlString = "photo"
        case phone = "phone"
        case address = "address"
        case galleryCount = "gallery_count"
        case the3DmodelCount = "3dmodel_count"
        case toursCount = "tours_count"
    }
}
