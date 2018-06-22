//
//  UserData.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import Foundation

struct UserData: Codable {
    let idUser: Int
    
    var username: String
    
    var token: String?
    
    enum CodingKeys: String, CodingKey {
        case idUser = "iduser"
        case username
        case token
    }
}
