//
//  ControlsViewController.swift
//  Mikomax
//
//  Created by Rafał Sowa on 11/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import SceneKit

protocol ControlsDelegate: class {
    func laodModel()
    func removeModel()
    func close()
}

class ControlsLayerVC: UIViewController {

    // MARK: - Public

    weak var delegate: ControlsDelegate?
    var state: State = .idle{
        didSet {
            if oldValue != state {
                renderState()
            }
        }
    }
    
    enum State {
        case idle
        case detecting
        case loading
        case loaded
    }

    // MARK: - Outlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var trashButton: UIButton!
    @IBOutlet weak var statusView: StatusView!
    @IBOutlet weak var closeButton: UIButton!
    // MARK: - Private
    
    private lazy var buttonAnimator = ButtonAnimator(frameView: self.view.frame)
    private lazy var feedbackGenerator = FeedbackGenerator()

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        statusView.hide(isAnimated: false)
        buttonAnimator.hide(button: closeButton, inDirection: .left, duration: 0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        buttonAnimator.show(button: closeButton)
    }
    // MARK: - Actions
    
    @IBAction func loadModel(_ sender: UIButton) {
        delegate?.laodModel()
    }
    
    @IBAction func close(_ sender: UIButton) {
        feedbackGenerator.cancelled()
        delegate?.close()
    }
    
    @IBAction func removeModel(_ sender: Any) {
        delegate?.removeModel()
    }
}

private extension ControlsLayerVC {
    func renderState() {
        switch state {
        case .idle:
            activityIndicator.stopAnimating()
            buttonAnimator.hide(button: trashButton, inDirection: .bottom)
            buttonAnimator.show(button: addButton)
            statusView.show(with: "Surface detected. Tap \"+\" to ADD object to your room.")
            
        case .detecting:
            activityIndicator.stopAnimating()
            buttonAnimator.hide(button: trashButton, inDirection: .bottom)
            buttonAnimator.hide(button: addButton, inDirection: .bottom)
            statusView.show(with: "Move around you to detect surface.")

        case .loading:
            buttonAnimator.hide(button: addButton, inDirection: .bottom)
            activityIndicator.startAnimating()
            statusView.show(with: "Wait a sec...")
            
        case .loaded:
            activityIndicator.stopAnimating()
            buttonAnimator.show(button: trashButton)
            buttonAnimator.hide(button: addButton, inDirection: .bottom)
            statusView.show(with: "Move object as you want!")
            statusView.hide(isAnimated: true, withDelay: 2)

        }
    }
}





