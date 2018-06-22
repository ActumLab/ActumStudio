//
//  StateViewController.swift
//  Mikomax
//
//  Created by Rafał Sowa on 10/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit

protocol StateViewInput {
    func show(_ state: StateViewController.State)
}



class StateViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var headLabel: UILabel!
    @IBOutlet weak var subheadLabel: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var indicatorLabel: UILabel!
    @IBOutlet weak var indicatorStack: UIStackView!
    
    // MARK: - Public
    var reloadAction: () -> Void = {}
    
    
    // MARK: - Private
    private var state: State = .loading(nil) {
        didSet {
            renderState(state)
        }
    }
    
    enum State {
        case content
        case empty
        case loading(String?)
        case error(AppError)
        
        var title: String {
            switch self {
            case .empty:
                return "No products."
                
            case let .loading(msg):
                guard let msg = msg else {
                    return "Loading..."
                }
                
                return msg

            case .error(let error):
                return error.title
                
            default:
                return ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        switch state {
        case .empty, .error:
            reloadAction()

        default:
            break
        }
    }
    
    /// Render view for state
    private func renderState(_ state: State) {
        switch state {
        case .content:
            view.isHidden = true
            
        case .empty:
            view.isHidden = false
            indicatorStack.isHidden = true
            headLabel.isHidden = false
            subheadLabel.isHidden = false
            headLabel.text = state.title
            
        case .loading:
            view.isHidden = false
            indicatorStack.isHidden = false
            headLabel.isHidden = true
            subheadLabel.isHidden = true
            indicatorLabel.text = state.title
            indicator.startAnimating()

        case .error:
            view.isHidden = false
            indicatorStack.isHidden = true
            headLabel.isHidden = false
            subheadLabel.isHidden = false
            headLabel.text = state.title

        }
    }
}

extension StateViewController: StateViewInput {
    func show(_ state: StateViewController.State) {
        self.state = state
    }
}
