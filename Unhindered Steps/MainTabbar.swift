//
//  MainTabbar.swift
//  Unhindered Steps
//
//  Created by Emincan Antalyalı on 2.05.2023.
//

import UIKit

class MainTabbar: UITabBarController {

   
    
    override func viewDidLoad() {
        super.viewDidLoad()

      
        
        
        let mapVc = MapViewController()
     
        let profileVc = ProfileViewController()
        let profileNC = UINavigationController(rootViewController: profileVc)
        
        mapVc.tabBarItem.image = UIImage(systemName: "map")
        profileNC.tabBarItem.image = UIImage(systemName: "person.2")
        
        mapVc.title = "Harita"
        profileNC.title = "Profil"
        
        tabBar.tintColor = .label
        
        setViewControllers([mapVc,profileNC], animated: true)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
