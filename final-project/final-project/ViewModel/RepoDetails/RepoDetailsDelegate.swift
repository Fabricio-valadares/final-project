//
//  RepoDetailsDelegate.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 05/04/22.
//

import Foundation
import UIKit

protocol RepoDetailsDelegate: AnyObject {
    func favoriteUpdateFavorite()
    func favoriteUpdateFavoriteError(_ error: String)
}
