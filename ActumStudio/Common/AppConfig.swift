//
//  AppConfig.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
struct AppConfig {
    
    static var plistFileName: String {
        #if DEV
            return "ConfigApi-Dev"
        #else
            return "ConfigApi-Prod"
        #endif
    }
    
    static var modelsAssetsPath: String {
        return "Models.scnassets/Texture/Colors/"
    }
    
    struct Url {
        static var api: URL {
            guard let stringForURL = string("URL API") else {
                fatalError("Bad url in info.plist")
            }
            
            return URL(string: stringForURL)!
        }
    }
    struct User {
        static var id: Int {
            guard let id = int(for: "USER ID") else {
                fatalError()
            }
            
            return id
        }

    }
    
}

private extension AppConfig {
    static func bool(for key: String) -> Bool? {
        guard let path = Bundle.main.path(forResource: AppConfig.plistFileName, ofType: "plist") else {
            return nil
        }
        
        guard let dictRoot = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        
        return dictRoot[key] as? Bool
    }
    
    static func int(for key: String) -> Int? {
        guard let path = Bundle.main.path(forResource: AppConfig.plistFileName, ofType: "plist") else {
            return nil
        }
        
        guard let dictRoot = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        
        return dictRoot[key] as? Int
    }
    static func string(_ key: String) -> String? {
        guard let path = Bundle.main.path(forResource: AppConfig.plistFileName, ofType: "plist") else {
            return nil
        }
        
        guard let dictRoot = NSDictionary(contentsOfFile: path) else {
            return nil
        }
        
        return (dictRoot[key] as? String)?.replacingOccurrences(of: "\\", with: "")
    }
    
}
