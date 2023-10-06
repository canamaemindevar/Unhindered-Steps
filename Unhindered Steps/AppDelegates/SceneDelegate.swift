//
//  SceneDelegate.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 30.04.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    let loginVc = LoginView()
    let registerVc = RegisterView()
    let mainTabbar = MainTabbar()
    let profileVc = ProfileView()

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        window?.rootViewController = checkUser()
        window?.makeKeyAndVisible()
        loginVc.routeRegisterDelegate = self
        loginVc.loginSuccesDelegate = self
        registerVc.registerSuccesDelegate = self
    }

    func sceneDidDisconnect(_: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func checkUser() -> UIViewController {
        var targetVc: UIViewController = RegisterView()
        CoreDataManager.shared.getDataForFavs(completion: { response in
            switch response {
            case let .success(success):
                if success.count != 0 {
                    targetVc = self.mainTabbar

                } else {
                    targetVc = self.loginVc
                }

            case .failure:
                targetVc = self.loginVc
            }

        })

        return targetVc
//        if LocalState.hasOnboarded {
//            return mainTabbar
//        }else {
//            return loginVc
//          //  return  UINavigationController(rootViewController: loginVc)
//        }
    }
}

extension SceneDelegate: LoginViewRouteRegister {
    func routeToRegister() {
        setRootViewController(registerVc)
    }
}

extension SceneDelegate: LoginSuccesfullInterface {
    func routeToTabbar() {
        setRootViewController(mainTabbar)
    }
}

extension SceneDelegate: RegisterSuccesfullDelegate {
    func registerSuccesfull() {
        setRootViewController(loginVc)
    }
}

extension SceneDelegate {
    func setRootViewController(_ targetVc: UIViewController, animated: Bool = true) {
        guard animated, let window = window else {
            self.window?.rootViewController = targetVc
            self.window?.makeKeyAndVisible()
            return
        }
        DispatchQueue.main.async {
            window.rootViewController = targetVc
            window.makeKeyAndVisible()
            UIView.transition(with: window,
                              duration: 0.7,
                              options: .transitionCrossDissolve,
                              animations: nil)
        }
    }
}
