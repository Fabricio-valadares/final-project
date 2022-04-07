//
//  HomeViewModel.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation
import AVFoundation

class HomeViewModel {
    private let service = FetchGitHubServices()
    
    public var delegate:HomeDelegate?
    
    public var repositories = [Item](){
        didSet{
            DispatchQueue.main.async {
                self.delegate?.updateTableView()
            }
        }
    }
    
    public var filteredRepos = [Item](){
        didSet{
            DispatchQueue.main.async {
                self.delegate?.updateTableView()
            }
        }
    }
    
    public var isAsc:Bool = false
    
    public func fetchRepositories() {
        service.fetchAll { result in
            switch result {
                
            case .success(let repositories):
                self.repositories = repositories
            case .failure(let error):
                self.delegate?.fetchRepositoriesError(error.localizedDescription)
            }
        }
    }
    
    public func orderRepositories() {
        if(isAsc) {
            repositories.sort {$0.name.lowercased() < $1.name.lowercased()}
            isAsc = false
        } else {
            repositories.sort {$0.name.lowercased() > $1.name.lowercased()}
            isAsc = true
        }
    }
    
    public func filterRepositories(_ parameter: String) {
        filteredRepos = repositories.filter{ repo in
            return repo.name.lowercased().contains(parameter.lowercased())
         }
    }
}
