//
//  DownloadVC.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 28/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
protocol InvalidSessionDelegate{
    func dissmisAndInvalidateSession()
}

class DownloadVC: UIViewController {

    // MARK: - Private
    
    private let presenter: DownloadPresenter
    private let stateVC: StateViewController

    // MARK: - Init
    
    required init(presenter: DownloadPresenter) {
        self.presenter = presenter
        stateVC = StateViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configure(viewController: self)
        
        setupView()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default // .default
    }
    
    // MARK: - Actions
    
    @IBAction func close(_ sender: UIButton) {
        presenter.didClickDismissButton()
    }
    
    // MARK: - Private Helpers
    
    private func setupView() {
        add(child: stateVC, isFullScreen: true)
        view.sendSubview(toBack: stateVC.view)
        
        stateVC.reloadAction = { [weak self] in
            self?.presenter.viewDidLoad()
        }
    }
    
}

extension DownloadVC: DownloadView {
    func showStateScreen(_ state: StateViewController.State) {
        stateVC.show(state)
    }
    
    func dismiss() {
        self.dismiss(animated: false, completion: nil)
//        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func modelLoaded(_ model: ModelAR) {
        let ar = AugmentedRealityRootVC(modelAR: model)
        ar.delegate = self
        self.addChildViewController(ar)
        ar.view.frame = self.view.frame
        self.view.addSubview(ar.view)
        ar.didMove(toParentViewController: self)
    }
}

extension DownloadVC: InvalidSessionDelegate {
    func dissmisAndInvalidateSession() {
//        self.viewModel.downloadService.downloadSession.invalidateAndCancel()
        presenter.didClickDismissButton()
    }
}

