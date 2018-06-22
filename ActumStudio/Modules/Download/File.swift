//
//  File.swift
//  House360
//
//  Created by Rafał Sowa on 11.10.2017.
//  Copyright © 2017 ActumLab. All rights reserved.
//

import Foundation
class File {
    let name: String
    let downloadURL: URL
    
    init(name: String) {
        self.name = name
        self.downloadURL = URL(string: name)!
    }
}
