//
//  Details.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import UIKit

struct DetailsViewModel {
    var productId: Int = 0
    var title = ""
    var description = ""
    var priceDescriptor = LabelStackViewDescriptor(image: UIImage(named: "price")!, text: "")
    var phoneDescriptor = LabelStackViewDescriptor(image: UIImage(named: "phone")!, text: "")
    var addressDescriptor = LabelStackViewDescriptor(image: UIImage(named: "home")!, text: "")
    var linkDescriptor = ButtonStackViewDescriptor(image: UIImage(named: "cursor"), text: "")
}
