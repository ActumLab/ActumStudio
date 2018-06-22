//
//  ProductsIntercator.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import Moya
import Alamofire
/*
 * The Interactor responsible for implementing
 * the business logic of the module.
 */
class ProductsInteractor: ProductsInteractorInput {
    
    weak var output: ProductsInteractorOutput!
    
    // MARK: - Private
    
    private let provider: MoyaProvider<ProductsApi>

    // MARK: - Init
    
    required init(provider: MoyaProvider<ProductsApi>) {
        self.provider = provider
    }
    
    // MARK: - Request api
    
    func fetchProducts() {
        guard  NetworkReachabilityManager()!.isReachable else {
            output.productsFetchFailed(error: .netowrkIsUnreachable)
            return
        }
        
        provider.request(.products) { [weak self] (result) in
            switch result {
            case let .success(response):
                do {
                    let products = try response.map([Product].self)
                    if products.count > 0 {
                        self?.output.productsFetched(products: products)
                    } else {
                        self?.output.productsEmpty()
                    }
                } catch {
                    self?.output.productsFetchFailed(error: .server)
                }
                
                break
            case let .failure(error):
                print("Error: \(error)")
                self?.output.productsFetchFailed(error: .server)
                break
            }
        }
    }
}
