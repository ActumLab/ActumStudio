//
//  LabelStackViewDescriptor.swift
//  Mikomax
//
//  Created by Rafał Sowa on 15/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

struct LabelStackViewDescriptor {
    var text: String
    var image: UIImage?
    
    var isVisible: Bool {
        get {
            return text.count != 0
        }
    }
    
    init(image: UIImage?, text: String) {
        self.image = image
        self.text = text
    }
}
