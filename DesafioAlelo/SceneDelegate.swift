//
//  SceneDelegate.swift
//  DesafioAlelo
//
//  Created by Virtual Machine on 20/11/23.
//

import UIKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        window?.backgroundColor = UIColor(red: 34/255, green: 154/255, blue: 0/255, alpha: 1)
        let layout = UICollectionViewFlowLayout()
        window?.rootViewController = UINavigationController(rootViewController: ProductListViewController(collectionViewLayout: layout))
        UINavigationBar.appearance().barTintColor = UIColor(red: 34/255, green: 154/255, blue: 0/255, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        window?.makeKeyAndVisible()
    }
}
