//
//  LoginInteractor.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import CryptoSwift
class LoginInteractor: LoginInteractorInput {

    // MARK: - Public
    
    weak var output: LoginInteractorOutput!
    
    // MARK: - Private
    
    private let provider: MoyaProvider<ProductsApi>
    
    // MARK: - Init

    required init(provider: MoyaProvider<ProductsApi>) {
        self.provider = provider
    }
    
    // MARK: - Request api
    
    func login(username: String, password: String, saveIfSuccess: Bool) {
        guard  NetworkReachabilityManager()!.isReachable else {
            output.loginFailed(error: ApiError.netowrkIsUnreachable)
            return
        }
        
        provider.request(.login(username: username, password: password.sha1())) { [weak self] (result) in
            switch result {
            case let .success(response):
                print(response.data)
                do {
                    let loginResponse = try response.map(LoginResponse.self)
                    if loginResponse.isSuccess() {
                        
                        UserDefaults.save(loginResponse.data?.idUser, for: .userId)
                        
                        if saveIfSuccess {
                            UserDefaults.save(username, for: .email)
                            UserDefaults.save(password, for: .password)
                            UserDefaults.save(saveIfSuccess, for: .passIsSaved)
                        } else {
                            UserDefaults.save(nil, for: .email)
                            UserDefaults.save(nil, for: .password)
                            UserDefaults.save(saveIfSuccess, for: .passIsSaved)
                        }
                        
                        self?.output.loginSuccess()
                    } else {
                        self?.output.loginFailed(error: ApiError.message(loginResponse.message))
                    }
                    
                } catch {
                    self?.output.loginFailed(error: ApiError.server)
                }
                
            case let .failure(error):
                print("Error: \(error)")
                self?.output.loginFailed(error: ApiError.server)
            }
        }
    }
}
