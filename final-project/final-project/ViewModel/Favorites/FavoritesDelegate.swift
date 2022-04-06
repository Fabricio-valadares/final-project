//
//  FavoritesDelegate.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 05/04/22.
//

import Foundation
import UIKit

protocol FavoritesDelegate: AnyObject {
    func fetchFavoritesSuccess()
    func fetchFavoritesErro(_ error: String)
}
