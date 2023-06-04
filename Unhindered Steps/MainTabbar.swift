//
//  MainTabbar.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 2.05.2023.
//

import UIKit

class MainTabbar: UITabBarController {

    let mapVc = MapViewController()
 
    let profileVc = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        let profileNC = UINavigationController(rootViewController: profileVc)
        mapVc.tabBarItem.image = UIImage(systemName: "map")
        profileNC.tabBarItem.image = UIImage(systemName: "person.2")
        
        mapVc.title = "Harita"
        profileNC.title = "Profil"
        
        tabBar.tintColor = .label
        
        setViewControllers([mapVc,profileNC], animated: true)
    }
}
