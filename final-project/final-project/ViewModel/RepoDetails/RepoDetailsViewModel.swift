//
//  RepoDetailsViewModel.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 05/04/22.
//

import Foundation

class RepoDetailsViewModel {
    
    weak var delegate: RepoDetailsDelegate?
    
    var repository: Repository?
    
    var isFavorited: Bool = false
    
    public lazy var favoritedRepos = [Repository]() {
      didSet {
          DispatchQueue.main.async {
              self.setFavorited()
          }
        }
      }
    
    func favoriteItem() {
        ManagedObjectContext.shared.save(item: repository!) { result in
            switch result {
            case .Success:
                self.getMappedToIdFavoritedRepositories()
            case .Error(let error):
                delegate?.favoriteUpdateFavoriteError(error)
            }
        }
    }
    
    func unfavoriteItem() {
        ManagedObjectContext.shared.delete(id: repository!.id) { result in
            switch result {
            case .Success:
                self.getMappedToIdFavoritedRepositories()
            case .Error(let error):
                delegate?.favoriteUpdateFavoriteError(error)
            }
        }
    }
    
    private func setFavorited() {
        isFavorited = favoritedRepos.contains(where: { item in
            item.id == repository?.id
        })
        
        delegate?.favoriteUpdateFavorite()
    }
    
    func getMappedToIdFavoritedRepositories() {
       favoritedRepos = ManagedObjectContext.shared.list { result in
            switch result {
            case .Success:
                self.setFavorited()
            case .Error(let error):
                delegate?.favoriteUpdateFavoriteError(error)
            }
        }
    }
}
