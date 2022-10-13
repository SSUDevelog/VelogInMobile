//
//  SceneDelegate.swift
//  iOS_Velog
//
//  Created by 홍준혁 on 2022/10/08.
//
//
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.windowScene = windowScene
        // 루트 뷰 컨트롤러가 될 뷰컨트롤러 생성 & 위에서 생성한 뷰 컨트롤러 네비게이션 컨트롤러 생성
        let navigationController = UINavigationController(rootViewController: SignInViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
 
