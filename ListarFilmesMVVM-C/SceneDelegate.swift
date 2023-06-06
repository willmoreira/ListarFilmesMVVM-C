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
        guard let _ = (scene as? UIWindowScene) else { return }
    }
}

