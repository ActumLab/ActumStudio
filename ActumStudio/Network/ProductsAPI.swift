//
//  ProductsAPI.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Moya
enum ProductsApi {
    case login(username: String, password: String)
    case products
    case product(id: Int)
    case photos(productId: Int)
    case models(productId: Int)
}


extension ProductsApi: TargetType {
    var baseURL: URL {
        return AppConfig.Url.api
    }
    
    var path: String {
        switch self {
        case .login(_, _):
            return "/auth/login"
        case .products:
            return "/products"
        case let .product(id):
            return "/products/\(id)"
        case .photos(_):
            return "/product-photos"
        case .models(_):
            return "/modelars"
        }
    }
    
    var method: Method {
        switch self {
        case .login:
            return .post
            
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .login(let username, let password):
            return .requestParameters(parameters:  ["username": username, "password": password], encoding: URLEncoding.httpBody)
        case .products:
            guard let userId = UserDefaults.int(for: .userId) else {
                fatalError()
            }
            return .requestParameters(parameters: ["user_iduser": userId], encoding: URLEncoding.queryString)
        case let .product(id):
               return .requestParameters(parameters: ["idproduct": id], encoding: URLEncoding.queryString)
        case let .photos(productId):
            return .requestParameters(parameters: ["product_idproduct": productId], encoding: URLEncoding.queryString)
            
        case let .models(productId):
            return .requestParameters(parameters: ["idproduct": productId], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
