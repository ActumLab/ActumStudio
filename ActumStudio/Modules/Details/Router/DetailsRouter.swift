//
//  Productrouter.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import SafariServices

class DetailsRouter: DetailsWireframe {
    
    // MARK: - Private
    private let rootRouter: RootRouting
    private let cameraManager: CameraMaanger
    
    // MARK: - Init
    
    required init(rootRouter: RootRouting, cameraManager: CameraMaanger) {
        self.rootRouter = rootRouter
        self.cameraManager = cameraManager
    }
    
    func presentAR(forProduct product: Product, in view: UIViewController?) {
        guard let id = product.idproduct else {
            return
        }
//        let ar = ScenekitTestVC()
//        view?.present(ar, animated: true, completion: nil)
        cameraManager.openViewControllerWithCameraUsage(from: view) { [weak self] in
            self?.rootRouter.showDownload(for: id, from: view)
        }
    }
    
    func presentURL(_ url: URL, in view: UIViewController?) {
        let vc = SFSafariViewController(url: url)
        view?.present(vc, animated: true, completion: nil)
    }
}

