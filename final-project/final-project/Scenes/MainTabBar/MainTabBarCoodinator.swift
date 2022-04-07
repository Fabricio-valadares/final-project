//
//  MainTabBarCoodinator.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation
import UIKit
 
class MainTabBarCoordinator: Coordinator {
    private(set) var chilCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let mainController = MainTabBar()
       // let homeController = HomeController()
        
       // let viewModel = HomeViewModel()
        
       // viewModel.coodinator = self
        
       // homeController.viewModel = viewModel
        
       navigationController.setViewControllers([mainController], animated: true)
    }
    
    func repoDetails() {
        
    }
}
