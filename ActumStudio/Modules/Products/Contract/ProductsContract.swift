//
//  ProductsContract.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import Moya
/*
 * Protocol that defines the view input methods.
 */
protocol ProductsView: class {
    init(presenter: ProductsPresentation) 
    func showStateScreen(_ state: StateViewController.State)
    func showProductsData(_ products: [Product])
}

/*
 * Protocol that defines the commands sent from the View to the Presenter.
 */
protocol ProductsPresentation: class {
    init(interactor: ProductsInteractorInput, router: ProductsWireframe)
    func configure(viewController: ProductsView)
    func viewDidLoad()
    func didSelectProduct(_ product: Product, in view: UIViewController?)
}

/*
 * Protocol that defines the Interactor's use case.
 */
protocol ProductsInteractorInput: class {
    init(provider: MoyaProvider<ProductsApi>)    
    func fetchProducts()
}

/*
 * Protocol that defines the commands sent from the Interactor to the Presenter.
 */
protocol ProductsInteractorOutput: class {
    func productsFetched(products: [Product])
    func productsFetchFailed(error: ApiError)
    func productsEmpty()
}

/*
 * Protocol that defines the possible routes from the Articles module.
 */
protocol ProductsWireframe: class {
    init(rootRouter: RootRouting)
    func presentDetails(forProduct product: Product, in view: UIViewController?)
}
