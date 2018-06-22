//
//  LoginRouter.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

class LoginRouter: LoginWireframe {
    
    // MARK: - Private
    
    private let rootRouter: RootRouting
    
    // MARK: - Init
    
    required init(rootRouter: RootRouting) {
        self.rootRouter = rootRouter
    }
    
    
    func presentProducts() {
        rootRouter.showProductsAsRootViewController()
    }
    
    func presentAlert(for error: AppError) {
        guard let vc = UIApplication.getPresentedViewController() else {
            return
        }
        
        let alert = UIAlertController(title: error.title, message: error.description, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
