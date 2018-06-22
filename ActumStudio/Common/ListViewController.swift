//
//  Created by Rafał Sowa on 11/04/2018.
//  Copyright © 2018 Rafał Sowa. All rights reserved.
//
import Foundation
import UIKit

/**
 
 #Sample
 
 struct News: ListItem {
 var isSelected: Bool = false
 var title: String
 init(title: String) {
 self.title = title
 }
 }
 
 var items = [News]()
 for item in 0...20 {
 items.append(News(title: "News \(item)"))
 }
 let listViewController = ListViewController(items: items) { (cell: CollectionViewCell, item: News) in
 cell.isSelected = item.isSelected
 cell.textLabel.text = item.title
 }
 
 listViewController.scrollDirection  = .horizontal
 listViewController.didSelect = { item in
 print(item.title)
 }
 */


protocol ListItem {
    var isSelected: Bool { get set }
}


class ListCell: UICollectionViewCell {
    class var identifier: String {
        return String(describing: self)
    }
    
    class var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

/// A view controller that specializes in managing a horizontal and vertical list collection view based on UICollectionViewController
class ListViewController<Item: ListItem, Cell: ListCell>: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    enum ListScrollDirection {
        case vertical(isSquare: Bool)
        case horizontal
        
        var collectionViewScrollDirection: UICollectionViewScrollDirection {
            switch self {
            case .vertical(_):
                return .vertical
            case .horizontal:
                return .horizontal
            }
        }
    }
    
    //MARK: - Public
    
    var items = [Item]()
    var configure: (Cell, Item) -> Void
    var didSelect: (Item) -> Void = { _ in }
    var edgeInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    var scrollDirection: ListScrollDirection = .vertical(isSquare: true) {
        didSet {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = edgeInset
            layout.scrollDirection = scrollDirection.collectionViewScrollDirection
            collectionView?.collectionViewLayout = layout
        }
    }
    var selectedIndexPath: IndexPath?
    
    
    /// Initializes a horizontal list view controller and configures the collection view with the provided items.
    init(items: [Item], configure: @escaping (Cell, Item) -> Void ) {
        self.configure = configure
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        self.items = items
    }
    
    /// Init required by compiler
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateData(items: [Item]) {
        selectedIndexPath = nil
        self.items = items
        self.collectionView?.reloadData()
    }
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(Cell.nib, forCellWithReuseIdentifier: Cell.identifier)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = edgeInset
        layout.scrollDirection = scrollDirection.collectionViewScrollDirection
        collectionView?.collectionViewLayout = layout
        collectionView?.backgroundColor = .white
    }
    
    // MARK: Returns size for cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch scrollDirection {
        case let .vertical(isSquare):
            let width = collectionView.frame.width - (edgeInset.left + edgeInset.right)
            return CGSize(width: width, height: isSquare ? width : 44)
        default:
            let height = collectionView.frame.height - (edgeInset.top + edgeInset.bottom)
            return CGSize(width: height, height: height)
        }
    }
    
    // MARK: Returns spacing between cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return edgeInset.left
    }
    // MARK: Number of sections
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // MARK: Number of items in section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: Returns a cell for item
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = items[indexPath.row]
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell
        configure(cell, item)
        return cell
    }
    
    // MARK: Handle tap on item
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectItem(at: indexPath)
    }
    
    func selectItem(at indexPath: IndexPath) {
        collectionView?.deselectItem(at: indexPath, animated: true)
        // First selection, just set it and reload that cell
        guard let selectedIndexPath = selectedIndexPath else {
            self.selectedIndexPath = indexPath
            items[indexPath.row].isSelected = true
            collectionView?.reloadItems(at: [indexPath])
            didSelect(items[indexPath.row])
            return
        }
        // Reset to none selected and reload that cell
        if selectedIndexPath == indexPath {
            self.selectedIndexPath = nil
            items[indexPath.row].isSelected = false
            collectionView?.reloadItems(at: [indexPath])
        } else {
            // Set the new selected index and reload the previous and new cells.
            let indexPathsToRefresh = [indexPath, selectedIndexPath]
            items[indexPath.row].isSelected = true
            items[selectedIndexPath.row].isSelected = false
            self.selectedIndexPath = indexPath
            collectionView?.reloadItems(at: indexPathsToRefresh)
        }
        didSelect(items[indexPath.row])
    }
}
