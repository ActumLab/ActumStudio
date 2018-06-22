//
//  RootViewController.swift
//  Mikomax
//
//  Created by Rafał Sowa on 11/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import SceneKit
import AwesomeAR
import AudioToolbox

class AugmentedRealityRootVC: UIViewController {

    // MARK: - Public
    
    var delegate: InvalidSessionDelegate?
    
    // MARK: - Private
    private lazy var feedbackGenerator = FeedbackGenerator()
    private let arView: ARLayerVC
    private let controlsView: ControlsLayerVC
    private let modelAR: ModelAR
    private var surfaceIsDetected: Bool = false
    private var arrowsHideTimer: Timer?
    private var soundID: SystemSoundID = 0

    // MARK: - Init
    
    init(modelAR: ModelAR) {
        self.modelAR = modelAR
        arView = ARLayerVC()
        controlsView = ControlsLayerVC()
        let url = Bundle.main.url(forResource: "dumb", withExtension: "mp3")!
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        arView.delegate = self
        controlsView.delegate = self
        controlsView.state = .detecting
        
        arView.loadModel = { [weak self] in
            return self?.modelAR
        }
    }
    
    func playDropSound() {
        AudioServicesPlaySystemSound(soundID)
    }
}

extension AugmentedRealityRootVC {
    
    private func setupView() {
        buildHierarchy()
    }
    
    private func buildHierarchy() {
        add(child: arView, isFullScreen: true)
        add(child: controlsView, isFullScreen: true)
        view.sendSubview(toBack: arView.view)
    }
}

extension AugmentedRealityRootVC: ControlsDelegate {
    func removeModel() {
        arView.removeLastObject3DFromScene()
    }
    
    func laodModel() {
        arView.loadObject3DToScene()
    }
    
    func close() {
        delegate?.dissmisAndInvalidateSession()
    }
}

extension AugmentedRealityRootVC: ARViewControllerDelegate {
    func featuresDetected() {
        guard !surfaceIsDetected else {
            return
        }
        
        surfaceIsDetected = true
        
        print("Features detected")
        DispatchQueue.main.async { [weak self] in
            self?.controlsView.state = .idle
        }
    }
    
    func planeDetected() {
        guard !surfaceIsDetected else {
            return
        }
        
        surfaceIsDetected = true

        print("Plane detected")
        DispatchQueue.main.async { [weak self] in
            self?.controlsView.state = .idle
        }
    }
    
    func object3DdidStartLoading() {
        controlsView.state = .loading
    }
    
    func object3DdidEndLoading() {
        controlsView.state = .loaded
        playDropSound()
        feedbackGenerator.peek()
        
        arrowsHideTimer?.invalidate()
        arrowsHideTimer = nil
        arrowsHideTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] (timer) in
            let action = SCNAction.fadeOut(duration: 1.0)
            let directionsArrows = self?.arView.arView.sceneView.scene.rootNode.childNode(withName: "dir", recursively: true)
            let rotationArrows = self?.arView.arView.sceneView.scene.rootNode.childNode(withName: "rot", recursively: true)
            directionsArrows?.runAction(action, completionHandler: {
                directionsArrows?.removeFromParentNode()
            })
            
            rotationArrows?.runAction(action, completionHandler: {
                rotationArrows?.removeFromParentNode()
            })
        }
        
    }
    
    func object3DdidRemoveFromScene() {
        controlsView.state = .idle
        feedbackGenerator.cancelled()
        
        arrowsHideTimer?.invalidate()
        arrowsHideTimer = nil
    }
}





