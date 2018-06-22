//
//  LabelStackView.swift
//  Mikomax
//
//  Created by Rafał Sowa on 15/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

protocol LabelStackViewUpdate {
    func update(for descriptor: LabelStackViewDescriptor)
}

class LabelStackView: UIStackView {
    
    private let imageView = UIImageView()
    private let label = UILabel()
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupImageView()
        setupLabel()
        
        setupStack(for: [imageView, label])
        setupStackLayout()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupStack(for views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    private func setupStackLayout() {
        axis = .horizontal
        distribution = .fillProportionally
        spacing = 10
    }
    
    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    private func setupLabel() {
        label.textColor = UIColor(named: "Gray")
        label.font = UIFont(name: "ArialMT", size: 16)
    }
}

extension LabelStackView: LabelStackViewUpdate {
    func update(for descriptor: LabelStackViewDescriptor) {
        guard descriptor.isVisible else {
            isHidden = true
            return
        }
        
        isHidden = false
        
        imageView.image = descriptor.image
        label.text = descriptor.text
    }
}
