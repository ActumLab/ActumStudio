//
//  GalleryCell.swift
//  Mikomax
//
//  Created by Rafał Sowa on 15/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import Kingfisher

class GalleryCell: ListCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var mainView: DesignableView!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.mainView.alpha = 1.0
                    self?.mainView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                }
            } else {
                UIView.animate(withDuration: 0.5) { [weak self] in
                    self?.mainView.alpha = 0.75
                    self?.mainView.transform = CGAffineTransform.identity
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupFor(_ item: GalleryItem) {
        isSelected = item.isSelected
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: item.url)
    }
    
}
