//
//  DownloadPresenter.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation

class DownloadPresenter: DownloadPresentation {
    
    // MARK: - Private
    
    private weak var view: DownloadView?
    private let interactor: DownloadInteractorInput
    private let router: DownloadWireframe
    private let productId: Int
    
    // MARK: - Init
    
    required init(productId: Int, interactor: DownloadInteractorInput, router: DownloadWireframe) {
        self.productId = productId
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - DownloadPresentation methods
    
    func configure(viewController: DownloadView) {
        view = viewController
    }
    
    func viewDidLoad() {
        view?.showStateScreen(.loading(nil))
        interactor.fetchModels(for: productId)
    }
    
    func didClickDismissButton() {
        interactor.cancelFetching()
        view?.dismiss()
    }
}

extension DownloadPresenter: DownloadInteractorOutput {
    func modelsFetched(_ model: ModelAR) {
//        view?.showStateScreen(.content)
//        view?.dismiss()
        view?.modelLoaded(model)
//        router.showAR(for: model)
    }
    
    func modelsFetchedFailed(error: ApiError) {
        view?.showStateScreen(.error(error))
    }
    
    func modelsEmpty() {
        
    }
    
    func progressMessage(_ msg: String) {
        view?.showStateScreen(.loading(msg))
    }
}
