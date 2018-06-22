//
//  AppDelegate.swift
//  ActumStudio
//
//  Created by Rafał Sowa on 25/05/2018.
//  Copyright © 2018 Actum Lab. All rights reserved.
//

import UIKit
import AwesomeAR

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Public
    
    var window: UIWindow?
    var backgroundSessionCompletionHandler: (() -> Void)?

    // MARK: - Private
    
    private lazy var appDependencies = AppDependencies()
    private lazy var router = RootRouter(appDependencies: appDependencies)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        showStatusBar()
        setupAR()
        setupRootWindow()
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        backgroundSessionCompletionHandler = completionHandler
    }
}

private extension AppDelegate {
    func showStatusBar() {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    func setupAR() {
        EnvironmentConfig.environmentMap = UIImage(named: "Models.scnassets/environment_blur.exr")
        EnvironmentConfig.environmentInensity = 1000
        EnvironmentConfig.baseIntensity = 40
    }
    
    func setupRootWindow() {
        window = UIWindow()
        router.installRootViewController(into: window!)
    }
}
