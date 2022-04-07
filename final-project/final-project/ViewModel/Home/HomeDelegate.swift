//
//  HomeDelegate.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation
import UIKit

protocol HomeDelegate: AnyObject {
    func updateTableView()
    func fetchRepositoriesError(_ error: String)
}
