//
//  ProductListView.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

class ProductListVC: UIViewController {

    // MARK: - Public
    
    var didSelectProduct: (_ product: Product) -> Void = { _ in }
    
    // MARK: Private
    
    private lazy var collectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        flow.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flow)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
        return collectionView
    }()
    
    private var products = [Product]()
    private let itemsPerRow: CGFloat
    private let sectionInsets: UIEdgeInsets

    // MARK: - Init
    
    init() {
        itemsPerRow = UIDevice.current.userInterfaceIdiom == .pad ? 3 : 2
        sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Public helpers
    
    func updateData(_ products: [Product]) {
        self.products = products
        collectionView.reloadData()
    }
}

// MARK: - Private helpers

private extension ProductListVC {
    func setupView() {
        view.addSubview(collectionView, isFullScreen: true)
    }
    
    func productFor(_ indexPath: IndexPath) -> Product {
        return products[indexPath.row]
    }
}

// MARK: - CollectionView Delegate

extension ProductListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let availableWidth = collectionView.bounds.width - ((itemsPerRow + 1) * sectionInsets.left)
        let yourWidth = availableWidth/itemsPerRow
        let yourHeight = yourWidth * 1.2
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.bottom
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = productFor(indexPath)
        didSelectProduct(item)
    }
}

// MARK: - CollectionView DataSource

extension ProductListVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            return UICollectionViewCell()
        }
        
        let product = productFor(indexPath)
        
        cell.layoutCell(for: product)
        return cell
    }
}
