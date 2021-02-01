//
//  SceneDelegate.swift
//  JuWan
//
//  Created by fanzhe on 2020/12/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow(windowScene: windowScene)
        self.window?.backgroundColor = UIColor(named: "color_white")
        self.window?.rootViewController = XZNavigationController.init(rootViewController: MainViewController())
        self.window?.makeKeyAndVisible()
    }
}

