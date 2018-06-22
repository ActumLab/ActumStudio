//
//  LoadingButton.swift
//  RoomCapture
//
//  Created by Rafał Sowa on 10/04/2018.
//  Copyright © 2018 ActumLab. All rights reserved.
//

import UIKit

protocol Loadable {
    func showLoading()
    func hideLoading()
}

class LoadingButton: DesignableButton {
    struct ButtonState {
        var state: UIControlState
        var title: String?
        var image: UIImage?
    }
    
    var isLoading: Bool = false
    
    private (set) var buttonStates: [ButtonState] = []
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = self.titleColor(for: .normal)
        
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true

        return activityIndicator
    }()
}

extension LoadingButton: Loadable {
    func showLoading() {
        activityIndicator.startAnimating()
        
        var buttonStates: [ButtonState] = []
        for state in [UIControlState.disabled] {
            let buttonState = ButtonState(state: state, title: title(for: state), image: image(for: state))
            buttonStates.append(buttonState)
            setTitle("", for: state)
            setImage(UIImage(), for: state)
        }
        
        self.buttonStates = buttonStates
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        for buttonState in buttonStates {
            setTitle(buttonState.title, for: buttonState.state)
            setImage(buttonState.image, for: buttonState.state)
        }
    }
}
