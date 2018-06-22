//
//  LoginVC.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import BEMCheckBox

struct KeyboardWillShowPayload {
    let endFrame: CGRect
    
    init(userInfo: [AnyHashable: Any]) {
        endFrame = userInfo[UIKeyboardFrameEndUserInfoKey] as! CGRect
    }
}

class LoginVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: LoadingButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var checkBox: BEMCheckBox!
    @IBOutlet weak var devAlertLabel: DesignableLabel!
    
    // MARK: - Private
    
    private let presenter: LoginPresentation
    
    // MARK: - Init
    
    required init(presenter: LoginPresentation) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configure(viewController: self)
        setupView()
        
        presenter.viewDidLoad()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    @IBAction func login(_ sender: DesignableButton) {
        loginButton.isEnabled = false
        loginButton.showLoading()
        presenter.didTapLogin(username: emailTextField.text ?? "", password: passwordTextField.text ?? "", saveIfSuccess: checkBox.on, in: self)
    }
    
    // MARK: - Private helpers
    
    private func setupView() {
        setupTextFields()
        setupCheckbox()
        
        #if DEV
            devAlertLabel.isHidden = false
        #else
            devAlertLabel.isHidden = true
        #endif
    }
    
    private func setupTextFields() {
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        let notification = NotificationCenter.default
        
        notification.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: nil) { [weak self] (notification) in
            self?.scrollView.contentInset = UIEdgeInsets.zero
        }
        
        notification.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: nil) { [weak self] (notification) in
            let payload = KeyboardWillShowPayload(userInfo: notification.userInfo!)
            self?.scrollView.contentInset.bottom = payload.endFrame.height + 10
        }
    }
    
    private func setupCheckbox() {
        checkBox.boxType = .square
        checkBox.onAnimationType = .fill
        checkBox.offAnimationType = .fill
    }
}

extension LoginVC: LoginView {
    func hideLoading() {
        loginButton.isEnabled = true
        loginButton.hideLoading()
    }
    
    func setCheckbox(isOn: Bool) {
        checkBox.on = isOn
    }
    
    func setEmail(_ value: String?) {
        emailTextField.text = value
    }
    
    func setPassword(_ value: String?) {
        passwordTextField.text = value
    }
}

extension LoginVC: UITextFieldDelegate{
    //MARK: - Handle return button on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            passwordTextField.resignFirstResponder()
        }
        
        return false
    }
}
