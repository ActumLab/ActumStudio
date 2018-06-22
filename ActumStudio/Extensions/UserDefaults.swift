//
//  UserDefaults.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
extension UserDefaults {
    enum Keys: String {
        case email = "email"
        case password = "password"
        case passIsSaved = "pass_is_saved"
        case user = "last_user"
        case userId = "user_id"
    }
    
    static func save(_ value: Any?, for key: Keys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    static func int(for key: Keys) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    static func string(for key: Keys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    
    static func bool(for key: Keys) -> Bool{
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    static func data(for key: Keys) -> Data? {
        return UserDefaults.standard.value(forKey: key.rawValue) as? Data
    }
}
