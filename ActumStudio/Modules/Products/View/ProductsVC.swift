//
//  ProductsViewController.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

class ProductsVC: UIViewController {

    // MARK: - Public
    
    
    // MARK: - Private
    
    private let presenter: ProductsPresentation
    private let listVC: ProductListVC
    private let stateVC: StateViewController
    
    // MARK: - Init
    
    required init(presenter: ProductsPresentation) {
        self.presenter = presenter
        listVC = ProductListVC()
        stateVC = StateViewController()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configure(viewController: self)
        setupView()
        setupNavBar()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private helpers
    
    private func setupView() {
        add(child: listVC, isFullScreen: true)
        add(child: stateVC, isFullScreen: true)

        
        stateVC.reloadAction = { [weak self] in
            self?.presenter.viewDidLoad()
        }
        
        listVC.didSelectProduct = { [weak self] product in
            self?.presenter.didSelectProduct(product, in: self)
        }
    }
    
    private func setupNavBar() {
        title = "ActumStudio"
        navigationController?.navigationBar.barTintColor = UIColor(named: "Primary")
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

extension ProductsVC: ProductsView {

    func showProductsData(_ products: [Product]) {
        stateVC.show(.content)
        listVC.updateData(products)
    }
    
    func showStateScreen(_ state: StateViewController.State) {
        stateVC.show(state)
    }
}
