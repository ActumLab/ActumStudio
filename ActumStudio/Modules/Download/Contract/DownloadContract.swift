//
//  DownloadContract.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import Moya

protocol DownloadView: class {
    init(presenter: DownloadPresenter)
    func showStateScreen(_ state: StateViewController.State)
    func dismiss()
    func modelLoaded(_ model: ModelAR)
}

protocol DownloadPresentation: class {
    init(productId: Int, interactor: DownloadInteractorInput, router: DownloadWireframe)
    func configure(viewController: DownloadView)
    
    func viewDidLoad()
    func didClickDismissButton()
}

protocol DownloadInteractorInput: class {
    init(provider: MoyaProvider<ProductsApi>)
    func fetchModels(for id: Int)
    func cancelFetching()
}

protocol DownloadInteractorOutput: class {
    func modelsFetched(_ model: ModelAR)
    func modelsFetchedFailed(error: ApiError)
    func modelsEmpty()
    func progressMessage(_ msg: String)
}

protocol DownloadWireframe {
    init(rootRouter: RootRouting)
    func showAR(for model: ModelAR)
}
