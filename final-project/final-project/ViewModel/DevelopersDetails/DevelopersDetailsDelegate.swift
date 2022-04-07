//
//  DevelopersDetailsDelegate.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation
import UIKit

protocol DevelopersDetailsDelegate : AnyObject {
    func callActionFail(_ error: String)
    func showView(viewController: UIViewController)
}
