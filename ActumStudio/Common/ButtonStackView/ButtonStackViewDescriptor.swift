//
//  ButtonStackViewDescriptor.swift
//  Mikomax
//
//  Created by Rafał Sowa on 15/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

struct ButtonStackViewDescriptor {
    var text: String
    var image: UIImage?
    var urlString: String = ""
    
    var url: URL? {
        get {
            return URL(string: urlString)
        }
    }
    
    var isVisible: Bool {
        get {
            return url != nil
        }
    }
    
    init(image: UIImage?, text: String) {
        self.image = image
        self.text = text
    }
}
