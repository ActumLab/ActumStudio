//
//  Photo.swift
//  Mikomax
//
//  Created by Rafał Sowa on 15/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation

struct Photo: Codable {
    let id: Int?
    let productId: Int?
    let name: String?
    let urlString: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idproductPhoto"
        case productId = "product_idproduct"
        case name = "name"
        case urlString = "image"
    }
}
