//
//  GalleryCell.swift
//  House360
//
//  Created by Rafał Sowa on 12.09.2017.
//  Copyright © 2017 ActumLab. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    class var identifier: String{
        return String(describing: self)
    }
    
    class var nib: UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    // MARK: - Setup view
    
    func layoutCell(for product: Product) {
        photoImageView.setImage(with: product.photoUrlString!)
        titleLabel.text = product.title
    }
}
