//
//  ButtonStackView.swift
//  Mikomax
//
//  Created by Rafał Sowa on 15/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
protocol ButtonStackViewUpdate {
    func update(for descriptor: ButtonStackViewDescriptor)
}

class ButtonStackView: UIStackView {
    
    private let imageView = UIImageView()
    private let button = UIButton()
    var action: ((URL) -> Void)?
    
    var url: URL?
    
    init() {
        super.init(frame: CGRect.zero)
        
        setupImageView()
        setupButton()
        
        setupStack(for: [imageView, button])
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
    
    private func setupButton() {
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor(named: "Primary"), for: .normal)
        button.titleLabel?.font = UIFont(name: "ArialMT", size: 16.0)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
    }
    
    @objc private func tapButton(sender: UIButton) {
        action?(url!)
    }
}

extension ButtonStackView: ButtonStackViewUpdate {
    func update(for descriptor: ButtonStackViewDescriptor) {
//        guard descriptor.isVisible else {
//            isHidden = true
//            return
//        }
        
        isHidden = false
        url = descriptor.url
        imageView.image = descriptor.image
        button.setTitle(descriptor.text, for: .normal)
        
    }
}
