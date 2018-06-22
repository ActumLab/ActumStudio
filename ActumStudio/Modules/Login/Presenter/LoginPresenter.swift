//
//  LoginPresenter.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

class LoginPresenter: LoginPresentation {
    

    // MARK: - Private
    private let interactor: LoginInteractorInput
    private let router: LoginWireframe
    private weak var view: LoginView?
    
    // MARK: - Init
    
    required init(interactor: LoginInteractorInput, router: LoginWireframe) {
        self.interactor = interactor
        self.router = router
    }

    // MARK: - LoginPresentation Methods
    
    func configure(viewController: LoginView) {
        self.view = viewController
    }
    
    func viewDidLoad() {
        let email = UserDefaults.string(for: .email)
        let password = UserDefaults.string(for: .password)
        let checkboxIsOn = UserDefaults.bool(for: .passIsSaved)
        view?.setCheckbox(isOn: checkboxIsOn)
        view?.setEmail(email)
        view?.setPassword(password)
    }
    
    func didTapLogin(username: String, password: String, saveIfSuccess: Bool, in view: UIViewController?) {
        interactor.login(username: username, password: password, saveIfSuccess: saveIfSuccess)
    }
}
extension LoginPresenter: LoginInteractorOutput {
    func loginFailed(error: AppError) {
        view?.hideLoading()
        router.presentAlert(for: error)
    }
    
    func loginSuccess() {
        router.presentProducts()
    }
}
