//
//  DownloadRouter.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation

class DownloadRouter: DownloadWireframe {

    // MARK: - Private
    private let rootRouter: RootRouting
    
    // MARK: - Init
    
    required init(rootRouter: RootRouting) {
        self.rootRouter = rootRouter
    }
    
    func showAR(for model: ModelAR) {
        rootRouter.showAR(for: model)
    }
}
