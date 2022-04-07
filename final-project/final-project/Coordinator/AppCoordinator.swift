//
//  AppCoordinator.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    private(set) var chilCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let navigationController = UINavigationController()
        
        
        chilCoordinators.append(homeCoordinator)
        
        homeCoordinator.start()
        
        window.rootViewController = navigationController
        
        window.makeKeyAndVisible()
    }
}
