//
//  DetailsVC.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import Kingfisher
import ARKit

class DetailsVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var bottomControl: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var openARButton: DesignableButton! {
        didSet {
            openARButton.set(image: UIImage(named: "ARGlyph"), title: openARButton.titleLabel?.text ?? "", titlePosition: .left, additionalSpacing: 20, state: .normal)
        }
    }

    @IBOutlet weak var gradientVIew: UIView! {
        didSet {
            gradientVIew.setGradient(topColor: UIColor.white.withAlphaComponent(0).cgColor, bottomColor: UIColor.white.cgColor)
        }
    }
    
    
    // MARK: - Private
    
    private let presenter: DetailsPresentation
    private let galleryVC: GalleryVC
    private let detailsStackView: DetailsStackView
    private let stateVC: StateViewController

    // MARK: - Init
    
    required init(presenter: DetailsPresenter) {
        self.presenter = presenter
        galleryVC = GalleryVC()
        detailsStackView = DetailsStackView()
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
        presenter.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @IBAction func openAR(_ sender: DesignableButton) {
        presenter.didClickARButon(in: self)
    }

    // MARK: - Private helpers
    
    private func setupView() {
        if !ARConfiguration.isSupported {
            bottomControl.isHidden = true
        }
        
        stateVC.reloadAction = { [weak self] in
            self?.presenter.viewDidLoad()
        }
        
        // Add Gallery to top of view
        addChildViewController(galleryVC)
        contentView.addSubview(galleryVC.view)
        galleryVC.didMove(toParentViewController: self)
        galleryVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        // Setup constraints of gallery
        galleryVC.view.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        galleryVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        galleryVC.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        galleryVC.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true

        // Add Details stackview to conteView thath is a root view of scroll view
        contentView.addSubview(detailsStackView)

        // Setup constraints of Details StackView
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.topAnchor.constraint(equalTo: galleryVC.view.bottomAnchor, constant: 16).isActive = true
        detailsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        detailsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        if (UIDevice.current.userInterfaceIdiom == .pad){
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0).isActive = true
        } else {
            detailsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -140).isActive = true
        }

        // Setup action closure in Details StackView
        detailsStackView.linkButtonStack.action = { [weak self] url in
            self?.presenter.didClickOpenUrlButton(url: url, in: self)
        }
        
        add(child: stateVC, isFullScreen: true)
    }
}

extension DetailsVC: DetailsView {
    func showDetails(for viewModel: DetailsViewModel) {
        stateVC.show(.content)

        title = viewModel.title
        
//        detailsStackView.headingLabel.text = viewModel.title
//        detailsStackView.descriptionLabel.text = viewModel.description
//
//        detailsStackView.addressLabelStack.update(for: viewModel.addressDescriptor)
//        detailsStackView.phoneLabelStack.update(for: viewModel.phoneDescriptor)
//        detailsStackView.priceLabelStack.update(for: viewModel.priceDescriptor)
//
//        detailsStackView.linkButtonStack.update(for: viewModel.linkDescriptor)
        
        detailsStackView.update(with: viewModel)
    }
    
    func showStateScreen(_ state: StateViewController.State) {
        stateVC.show(state)
    }
    
    func showImage(for url: URL) {
//        imageView.kf.setImage(with: url)
    }
    
    func showPhotos(_ photos: [GalleryItem]) {
        galleryVC.loadPhotos(photos)
    }
}
