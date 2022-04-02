
import UIKit

class MainTabBar: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTabBar()
  }
  
  private func configureTabBar() {
    
      
    tabBar.tintColor = .black
    viewControllers = [
      embedInNavigationController(vc: HomeController(), title: "Home", image: "house"),
      embedInNavigationController(vc: FavoritesController(), title: "Favoritos", image: "star"),
      embedInNavigationController(vc: SquadController(), title: "Time", image: "person.2"),
    ]
  }
  
  private func embedInNavigationController(vc: UIViewController, title: String, image: String) -> UIViewController {
    let nav = UINavigationController(rootViewController: vc)
    nav.tabBarItem.title = title
    nav.tabBarItem.image = UIImage(systemName: image)
    return nav
  }
  
}
