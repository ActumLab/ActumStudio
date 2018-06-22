//
//  LoginContract.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import Foundation
import Moya

protocol LoginView: class {
    init(presenter: LoginPresentation)
//    func showStateScreen(_ state: StateViewController.State)
    func hideLoading()
    func setCheckbox(isOn: Bool)
    func setPassword(_ value: String?)
    func setEmail(_ value: String?)
}

protocol LoginPresentation: class {
    init(interactor: LoginInteractorInput, router: LoginWireframe)
    func configure(viewController: LoginView)
    func viewDidLoad()
    func didTapLogin(username: String, password: String, saveIfSuccess: Bool, in view: UIViewController?)
}

protocol LoginInteractorInput: class {
    init(provider: MoyaProvider<ProductsApi>)
    func login(username: String, password: String, saveIfSuccess: Bool)
}

protocol LoginInteractorOutput: class {
    func loginFailed(error: AppError)
    func loginSuccess()
}

protocol LoginWireframe: class {
    init(rootRouter: RootRouting)
    func presentAlert(for error: AppError)
    func presentProducts()
}


