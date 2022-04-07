//
//  HomeCoordinator.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation
import UIKit

class HomeCoordinator: Coordinator {
    private(set) var chilCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeController = HomeController()
        
        let viewModel = HomeViewModel()
        
        viewModel.coodinator = self
        
        homeController.viewModel = viewModel
        
        navigationController.setViewControllers([homeController], animated: true)
    }
    
    func repoDetails() {
        
    }
}
