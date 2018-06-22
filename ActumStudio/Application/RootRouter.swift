//
//  RootRouter.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//
import UIKit

protocol RootRouting {
    func installRootViewController(into window: UIWindow)
    func showProductsAsRootViewController()
    func showDetailsViewController(for product: Product, from viewController: UIViewController?)
    func showDownload(for id: Int, from viewController: UIViewController?)
    func showAR(for model: ModelAR)
}

class RootRouter: RootRouting {
    
    // MARK: - Private
    
    private let appDependencies: AppDependencies
    
    // MARK: - Init
    
    init(appDependencies: AppDependencies) {
        self.appDependencies = appDependencies
    }
    
    // MARK: - Methods
    
    func installRootViewController(into window: UIWindow) {
        window.rootViewController = appDependencies.makeLogin(with: self)
        window.makeKeyAndVisible()
    }
    
    func showProductsAsRootViewController() {
        let productsViewController = appDependencies.makeProductsViewController(with: self)
        let appDelegate = UIApplication.shared.delegate
        guard let window =  appDelegate?.window as? UIWindow else {
            return
        }
        let nv = UINavigationController(rootViewController: productsViewController)
        nv.navigationBar.barStyle = .black
        
        var transitionOptions = UIWindow.TransitionOptions(direction: .toRight, style: .linear)
        transitionOptions.duration = 0.25
        transitionOptions.background = UIWindow.TransitionOptions.Background.solidColor(.white)
        
        window.setRootViewController(nv, options: transitionOptions)
    }
    
    func showDetailsViewController(for product: Product, from viewController: UIViewController?) {
        let detailsViewController = appDependencies.makeDetails(for: product, with: self)
        viewController?.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    func showDownload(for id: Int, from viewController: UIViewController?) {
        let downloadViewController = appDependencies.makeDownload(for: id, with: self)
        let nv = UINavigationController(rootViewController: downloadViewController)

        viewController?.navigationController?.present(nv, animated: true, completion: nil)
    }
    
    func showAR(for model: ModelAR) {
        guard let vc = UIApplication.getPresentedViewController() else {
            return
        }
        let ar = AugmentedRealityRootVC(modelAR: model)
        
//        vc.add(child: ar, isFullScreen: true)
//        vc.navigationController?.pushViewController(ar, animated: true)
    }
    
}
