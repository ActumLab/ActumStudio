//
//  ProductParser.swift
//  ActumStudio Prod
//
//  Created by Rafał Sowa on 08/06/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
class ProductParser {
    
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    func viewModel() -> DetailsViewModel {
        var viewModel = DetailsViewModel()
        
        viewModel.title = getValue(product.title)
        viewModel.description = getValue(product.description)
        viewModel.phoneDescriptor.text = getValue(product.phone)
        viewModel.addressDescriptor.text = getValue(product.address)
        viewModel.priceDescriptor.text = getValue(product.price)
        viewModel.linkDescriptor.text = "Read more"
        viewModel.linkDescriptor.urlString =  product.link ?? "" //product.link ?? "http://www.mikomaxsmartoffice.pl/en" //product.link ??
        
        return viewModel
    }
    
    private func getValue(_ value: Any?) -> String {
        
        return String(value, default: "")
    }
}

private extension String {
    init(_ value: Any?, default text: String) {
        if let value = value as? String {
            self = value.count > 0 ? value : text
            return
            
        } else if let value = value as? Int {
            self = (value < 0 || value == 0)  ? "" : "\(value)"
            self = self.count > 0 ? self : text
            return
        } else if let value = value as? Float {
            self = String(format: "%.0f", value.rounded())
            self = self.count > 0 ? self : text
            return
        }
        self = text
    }
}
