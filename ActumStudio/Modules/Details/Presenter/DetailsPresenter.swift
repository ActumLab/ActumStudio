//
//  DetailsPresenter.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

class DetailsPresenter : DetailsPresentation {
    
    // MARK: - Private
    
    private weak var view: DetailsView?
    private let interactor: DetailsInteractorInput
    private let router: DetailsWireframe
    private let product: Product
    
    // MARK: - Init
    
    required init(product: Product, interactor: DetailsInteractorInput, router: DetailsWireframe) {
        self.product = product
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - DetailsPresentation methods
    
    func configure(viewController: DetailsView) {
        self.view = viewController
    }
    
    func viewDidLoad() {
        view?.showStateScreen(.loading(nil))
        interactor.fetchProduct(for: product.idproduct)
        if let urlString = product.photoUrlString, let url = URL(string: urlString) {
            view?.showImage(for: url)
        }
    }
    
    func didClickARButon(in view: UIViewController?) {
        router.presentAR(forProduct: product, in: view)
    }
    
    func didClickOpenUrlButton(url: URL, in view: UIViewController?) {
        self.router.presentURL(url, in: view)
    }
}

extension DetailsPresenter: DetailsInteractorOutput {
    func productFetched(viewModel: DetailsViewModel) {
        view?.showDetails(for: viewModel)
    }
    
    func productFetchFailed(error: ApiError) {
        view?.showStateScreen(.error(error))
    }
    
    func image(url: URL) {
        view?.showImage(for: url)
    }
    
    func photosFetched(photos: [GalleryItem]) {
        view?.showPhotos(photos)
    }
    
    func photosFetchFailed(error: ApiError) {
        // TODO:
    }
    
    func photosEmpty() {
        // TODO:
    }
}
