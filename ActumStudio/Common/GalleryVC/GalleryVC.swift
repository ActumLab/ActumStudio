//
//  GalleryView.swift
//  Mikomax
//
//  Created by Rafał Sowa on 15/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import CollieGallery

class GalleryVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var listContainer: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    // MARK: - Private
    
    private lazy var listVC: ListViewController<GalleryItem, GalleryCell> = {
        let vc = ListViewController(items: [], configure: { (cell: GalleryCell, item) in
            cell.setupFor(item)
        })
        vc.view.backgroundColor = .clear
        vc.collectionView?.backgroundColor = .clear
        vc.edgeInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        vc.collectionView?.showsHorizontalScrollIndicator = false
        return vc
    }()
    private var selectedIndex: Int?
    
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listVC.scrollDirection = .horizontal
        listVC.didSelect = { [weak self] item in
            self?.selectedIndex = self?.listVC.selectedIndexPath?.item
            self?.imageView.kf.setImage(with: item.url)
        }
        setupView()
        addGestures()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func loadPhotos(_ photos: [GalleryItem]) {
        listVC.updateData(items: photos)
        selectedIndex = 0
        listVC.selectItem(at: IndexPath(item: 0, section: 0))
    }
    
    private func setupView() {
        
        let listView = listVC.view!
        listView.translatesAutoresizingMaskIntoConstraints = false
        addChildViewController(listVC)
        listContainer.addSubview(listView)
        listVC.didMove(toParentViewController: self)
        listContainer.bringSubview(toFront: listView)
        
        
        listView.leadingAnchor.constraint(equalTo: listContainer.leadingAnchor).isActive = true
        listView.trailingAnchor.constraint(equalTo: listContainer.trailingAnchor).isActive = true
        listView.topAnchor.constraint(equalTo: listContainer.topAnchor).isActive = true
        listView.bottomAnchor.constraint(equalTo: listContainer.bottomAnchor).isActive = true
    }
    
    private func addGestures() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = .right
        swipeRight.delegate = self
        self.imageView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = .left
        swipeLeft.delegate = self
        self.imageView.addGestureRecognizer(swipeLeft)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.respondToTapGesture))
        tap.delegate = self
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case .right:
                if let selectedIndex = selectedIndex {
                    let newIndex = selectedIndex - 1
                   
                    guard newIndex > -1 else {
                        return
                    }
                    
                    self.selectedIndex = newIndex
                    let indexPath = IndexPath(item: newIndex, section: 0)
                    print(indexPath)
                    listVC.selectItem(at: indexPath)
                    listVC.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
               
            case .left:
                if let selectedIndex = selectedIndex {
                    let newIndex = selectedIndex + 1
                    
                    guard newIndex < listVC.items.count else {
                        return
                    }
                    
                    self.selectedIndex = newIndex
                    let indexPath = IndexPath(item: newIndex, section: 0)
                    print(indexPath)

                    listVC.selectItem(at: indexPath)
                    listVC.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                }
                
            default:
                break
            }
        }
    }
    
    @objc private func respondToTapGesture(gesture: UITapGestureRecognizer) {
        let pictures = listVC.items.map { (item) -> CollieGalleryPicture  in
            return CollieGalleryPicture(url: item.url.absoluteString)
        }
        
        let options = CollieGalleryOptions()
        options.enableSave = false
        
        let gallery = CollieGallery(pictures: pictures, options: options)
        gallery.presentInViewController(self)

        if let selectedIndex = selectedIndex {
            gallery.scrollToIndex(selectedIndex)
        }
    }
}
extension GalleryVC: UIGestureRecognizerDelegate{
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
