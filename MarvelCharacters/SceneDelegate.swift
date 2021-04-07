//
//  SceneDelegate.swift
//  MarvelCharacters
//
//  Created by Hasan on 08.04.21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            self.window = UIWindow(windowScene: windowScene)
            let marvelCharactersVC = CharacterListVC()
            let mainNavigationController = UINavigationController(rootViewController: marvelCharactersVC)
            self.window!.rootViewController = mainNavigationController
            self.window!.makeKeyAndVisible()
        }
    }
}
