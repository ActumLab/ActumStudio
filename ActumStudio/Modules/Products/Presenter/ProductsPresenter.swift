//
//  ProductPresenter.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

/*
 * The Presenter is also responsible for connecting
 * the other objects inside a VIPER module.
 */
class ProductsPresenter: ProductsPresentation {
    
    // MARK: - Public
    
    
    // MARK: - Private
    
    private var interactor: ProductsInteractorInput
    private var router: ProductsWireframe
    private weak var view: ProductsView?
    
    // MARK: - Init
    
    required init(interactor: ProductsInteractorInput, router: ProductsWireframe) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - View Lifecycle
    
    func viewDidLoad() {
        view?.showStateScreen(.loading(nil))
        interactor.fetchProducts()
    }
    
    // MARK: - ProductsPresentation Methods
    
    func configure(viewController: ProductsView) {
        self.view = viewController
    }
    
    func didSelectProduct(_ product: Product, in view: UIViewController?) {
        router.presentDetails(forProduct: product, in: view)
    }
}

// MARK: - Products Interactor Output

extension ProductsPresenter: ProductsInteractorOutput {
    
    func productsFetched(products: [Product]) {
        view?.showProductsData(products)
    }
    
    func productsFetchFailed(error: ApiError) {
       view?.showStateScreen(.error(error))
    }
        
    func productsEmpty() {
        view?.showStateScreen(.empty)
    }
}
