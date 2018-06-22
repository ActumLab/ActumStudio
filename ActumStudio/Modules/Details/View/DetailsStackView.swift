//
//  DetailsView.swift
//  Mikomax
//
//  Created by Rafał Sowa on 17/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

class DetailsStackView: UIStackView {
    
    // MARK: - Labels
    
    lazy var headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Arial-BoldMT", size: 22)
        label.textColor = UIColor(named: "Black")
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "ArialMT", size: 16)
        label.textColor = UIColor(named: "Gray")
        label.numberOfLines = 0
        return label
    }()

    // MARK: - LabelStackViews
    
    lazy var addressLabelStack = LabelStackView()
    lazy var phoneLabelStack = LabelStackView()
    lazy var priceLabelStack = LabelStackView()
    
    // MARK: - ButtonStackViews
    
    lazy var linkButtonStack = ButtonStackView()
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero)
//        if (UIDevice.current.userInterfaceIdiom == .pad){
//            axis = .vertical
//            distribution = .fillProportionally
//            spacing = 32
//        } else {
            axis = .vertical
            distribution = .fillProportionally
            spacing = 8.0
//        }

        
        setupView()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: DetailsViewModel) {
        headingLabel.text = viewModel.title
        descriptionLabel.text = viewModel.description
        
        addressLabelStack.update(for: viewModel.addressDescriptor)
        phoneLabelStack.update(for: viewModel.phoneDescriptor)
        priceLabelStack.update(for: viewModel.priceDescriptor)
        
        linkButtonStack.update(for: viewModel.linkDescriptor)
    }
    
    private func setupView() {
//        if (UIDevice.current.userInterfaceIdiom == .pad){
//            let containerStack = UIStackView()
//            containerStack.axis = .horizontal
//            containerStack.distribution = .fill
//            containerStack.spacing = 10
//            containerStack.backgroundColor = .black
//
//            let leftStack = UIStackView()
//            leftStack.translatesAutoresizingMaskIntoConstraints = false
//            leftStack.axis = .vertical
//            leftStack.distribution = .fillProportionally
//            leftStack.backgroundColor = .red
//            leftStack.widthAnchor.constraint(equalToConstant: 270).isActive = true
//            leftStack.spacing = 8
//
//            let rightStack = UIStackView()
//            rightStack.translatesAutoresizingMaskIntoConstraints = false
//            rightStack.axis = .vertical
//            rightStack.distribution = .fillProportionally
//            rightStack.alignment = .top
//
//            leftStack.addArrangedSubview(addressLabelStack)
//            leftStack.addArrangedSubview(phoneLabelStack)
//            leftStack.addArrangedSubview(priceLabelStack)
//            leftStack.setCustomSpacing(20, after: priceLabelStack)
//            leftStack.addArrangedSubview(linkButtonStack)
//
//            rightStack.addArrangedSubview(descriptionLabel)
//
//            containerStack.addArrangedSubview(leftStack)
//            containerStack.addArrangedSubview(rightStack)
//
//            addArrangedSubview(headingLabel)
//            addArrangedSubview(containerStack)
//
//        } else {
            addArrangedSubview(headingLabel)
            setCustomSpacing(8, after: headingLabel)
            addArrangedSubview(descriptionLabel)
            setCustomSpacing(8, after: descriptionLabel)
            
            addArrangedSubview(addressLabelStack)
            addArrangedSubview(phoneLabelStack)
            addArrangedSubview(priceLabelStack)
            setCustomSpacing(20, after: priceLabelStack)
            addArrangedSubview(linkButtonStack)
//        }
    }
}
