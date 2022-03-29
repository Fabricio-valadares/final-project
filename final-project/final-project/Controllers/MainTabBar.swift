//
//  MainTabBar.swift
//  final-project
//
//  Created by Giovanna Moeller on 28/03/22.
//

import UIKit

class MainTabBar: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBar()
  }
  
  private func configureTabBar() {
    tabBar.tintColor = .black
    viewControllers = [
      embedInNavigationController(vc: HomeViewController(), title: "Home", image: "house"),
      embedInNavigationController(vc: FavoritesViewController(), title: "Favoritos", image: "star"),
      embedInNavigationController(vc: SquadViewController(), title: "Time", image: "person.2"),
    ]
  }
  
  private func embedInNavigationController(vc: UIViewController, title: String, image: String) -> UIViewController {
    let nav = UINavigationController(rootViewController: vc)
    nav.tabBarItem.title = title
    nav.tabBarItem.image = UIImage(systemName: image)
    return nav
  }
  
}
