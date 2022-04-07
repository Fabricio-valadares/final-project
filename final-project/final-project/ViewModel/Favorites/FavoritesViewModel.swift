//
//  FavoritesViewModel.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 05/04/22.
//

import Foundation

class FavoritesViewModel {
    weak var delegate: FavoritesDelegate?
    
    public var repositories = [Repository](){
        didSet{
            DispatchQueue.main.async {
                self.delegate?.fetchFavoritesSuccess()
            }
        }
    }
    
    func fetchRepositories() {
        repositories = ManagedObjectContext.shared.list { result in
            switch result {
                  case .Success:
                    print("success")
                  case .Error(let error):
                    delegate?.fetchFavoritesErro(error)
              }
          }
    }
    
    func getRepositoriesCount() -> Int {
        repositories.count
    }
}
