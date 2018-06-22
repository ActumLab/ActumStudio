//
//  DetailsContract.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import Moya

protocol DetailsView: class {
    init(presenter: DetailsPresenter)
    func showStateScreen(_ state: StateViewController.State)
    func showDetails(for viewModel: DetailsViewModel)
    func showImage(for url: URL)
    func showPhotos(_ photos: [GalleryItem])
}

protocol DetailsPresentation: class {
    init(product: Product, interactor: DetailsInteractorInput, router: DetailsWireframe)
    func configure(viewController: DetailsView)

    func viewDidLoad()
    func didClickARButon(in view: UIViewController?)
    func didClickOpenUrlButton(url: URL, in view: UIViewController?)
}

protocol DetailsInteractorInput: class {
    init(provider: MoyaProvider<ProductsApi>) 
    func fetchProduct(for id: Int?)
}

protocol DetailsInteractorOutput: class {
    func image(url: URL)
    
    func productFetched(viewModel: DetailsViewModel)
    func productFetchFailed(error: ApiError)
//    func productEmpty()
    
    func photosFetched(photos: [GalleryItem])
    func photosFetchFailed(error: ApiError)
    func photosEmpty()
}

protocol DetailsWireframe: class {
    init(rootRouter: RootRouting, cameraManager: CameraMaanger)
    func presentAR(forProduct product: Product, in view: UIViewController?)
    func presentURL(_ url: URL, in view: UIViewController?)
}
