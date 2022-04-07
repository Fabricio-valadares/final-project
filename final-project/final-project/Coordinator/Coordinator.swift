//
//  Coordinator.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation

protocol Coordinator: AnyObject {
    var chilCoordinators: [Coordinator] { get }
    
    func start()
}
