//
//  LoginResponse.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
struct LoginResponse: Codable {
    let status: String
    
    var message: String
    
    var data: UserData?
}

extension LoginResponse {
    func isSuccess() -> Bool {
        return status == "success"
    }
}

