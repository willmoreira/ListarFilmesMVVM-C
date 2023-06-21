//
//  SceneDelegate.swift
//  ListarFilmesMVVM-C
//
//  Created by William Moreira on 06/06/23.
//

import UIKit
import FirebaseCore

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        FirebaseApp.configure()
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let loginCoordinator = LoginCoordinator()
            let viewController = loginCoordinator.start()
            let navigationController = UINavigationController(rootViewController: viewController)
            loginCoordinator.navigationController = navigationController
            window.rootViewController = navigationController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

