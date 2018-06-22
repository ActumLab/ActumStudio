//
//  DetailsInteractor.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import Moya
import Alamofire

class DetailsInteractor: DetailsInteractorInput {
    
    // MARK: - Public
    
    weak var output: DetailsInteractorOutput!
    
    // MARK: - Private
    
    private let provider: MoyaProvider<ProductsApi>

    required init(provider: MoyaProvider<ProductsApi>) {
        self.provider = provider
    }
    
    func fetchProduct(for id: Int?) {
        guard  NetworkReachabilityManager()!.isReachable else {
            output.productFetchFailed(error: .netowrkIsUnreachable)
            return
        }
        
        guard let id = id else {
            output.photosFetchFailed(error: .server)
            return
        }
        
        provider.request(.product(id: id)) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    let product = try response.map(Product.self)
                    
                    if let viewModel = self?.processProduct(product) {
                        self?.output.productFetched(viewModel: viewModel)
                    } else {
                        self?.output.productFetchFailed(error: .server)
                    }
                } catch {
                    self?.output.productFetchFailed(error: .server)
                }
                
                break
            case let .failure(error):
                print("Error: \(error)")
                self?.output.productFetchFailed(error: .server)
                break
            }
        }
    }
    
    // TODO:
    func requestPhotos(for productId: Int) {
        provider.request(.photos(productId: productId)) { [weak self] result in
            switch result {
            case let .success(response):
                do {
                    let responsePhotos = try response.map([Photo].self)
                    if responsePhotos.count > 0 {
                        let photos = responsePhotos.filter({ (photo) -> Bool in
                            guard let urlString = photo.urlString, let _ = URL(string: urlString) else {
                                return false
                            }
                            
                            return true
                        }).map({ (photo) -> GalleryItem in
                            return GalleryItem(isSelected: false, url: URL(string: photo.urlString!)!)
                        })
                        
                        if photos.count > 0 {
                            self?.output.photosFetched(photos: photos)
                        } else {
                            self?.output.photosEmpty()
                        }
                    } else {
                        self?.output.photosEmpty()
                    }
                } catch {
                    print("Photos parse error: \(error.localizedDescription)")
                    self?.output.productFetchFailed(error: .server)
                }
                
            case let .failure(error):
                print("Fetch photos for Product Id: \(productId) failed with error: \(error.localizedDescription)")
                self?.output.productFetchFailed(error: .server)
            }
        }
    }
    
    // TODO: Out to external produc parser
    func processProduct(_ product: Product) -> DetailsViewModel{
        if let id = product.idproduct {
            requestPhotos(for: id)
        }
        
        let parser = ProductParser(product: product)
        let viewModel = parser.viewModel()
        
        if let photoUrlString = product.photoUrlString, let url = URL(string: photoUrlString) {
            output.image(url: url)
        }
        
        return viewModel
    }
}
