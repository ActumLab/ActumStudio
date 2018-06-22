//
//  AppDependencies.swift
//  Mikomax
//
//  Created by Rafał Sowa on 14/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import UIKit
import Moya
import Alamofire


import UIKit

class AppDependencies {
    private lazy var apiProvider = MoyaProvider<ProductsApi>(manager: AlamoifreManagerWithSSL.getAlamofireManager())
    private lazy var cameraManager = CameraMaanger()

    func makeLogin(with router: RootRouting) -> LoginVC {
        let router = LoginRouter(rootRouter: router)
        let interactor = LoginInteractor(provider: apiProvider)
        let presenter = LoginPresenter(interactor: interactor, router: router)
        interactor.output = presenter
        
        return LoginVC(presenter: presenter)
    }
    
    func makeProductsViewController(with router: RootRouting) -> ProductsVC {
        let router = ProductsRouter(rootRouter: router)
        let productsInteractor  = ProductsInteractor(provider: apiProvider)
        let productsPreseneter = ProductsPresenter(interactor: productsInteractor, router: router)
        productsInteractor.output = productsPreseneter
        
        return  ProductsVC(presenter: productsPreseneter)
    }
    
    func makeDetails(for product: Product, with router: RootRouting) -> DetailsVC {
        let router = DetailsRouter(rootRouter: router, cameraManager: cameraManager)
        let interactor = DetailsInteractor(provider: apiProvider)
        let presenter = DetailsPresenter(product: product, interactor: interactor, router: router)
        interactor.output = presenter
        
        return DetailsVC(presenter: presenter)
    }
    
    func makeDownload(for id: Int, with router: RootRouter) -> DownloadVC {
        let router = DownloadRouter(rootRouter: router)
        let interactor = DownloadInteractor(provider: apiProvider)
        let presenter = DownloadPresenter(productId: id, interactor: interactor, router: router)
        interactor.output = presenter
        
        return DownloadVC(presenter: presenter)
    }
}


