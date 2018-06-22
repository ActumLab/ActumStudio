//
//  Productrouter.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
/*
 * The Router responsible for navigation between modules.
 */
class ProductsRouter: ProductsWireframe {
    
    private let rootRouter: RootRouting
    
    required init(rootRouter: RootRouting) {
        self.rootRouter = rootRouter
    }
    
    func presentDetails(forProduct product: Product, in view: UIViewController?) {
        rootRouter.showDetailsViewController(for: product, from: view)
    }
}
