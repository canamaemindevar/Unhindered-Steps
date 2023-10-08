//
//  MainTabbar.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 2.05.2023.
//

import UIKit

final class MainTabbar: UITabBarController {
    let mapVc = MapView()

    let profileVc = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let profileNC = UINavigationController(rootViewController: profileVc)
        mapVc.tabBarItem.image = UIImage(systemName: "map")
        profileNC.tabBarItem.image = UIImage(systemName: "person.2")

        mapVc.title = "map".localized
        profileNC.title = "profile".localized

        tabBar.tintColor = .label

        setViewControllers([mapVc, profileNC], animated: true)
    }
}
