//
//  SquadViewModel.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 06/04/22.
//

import Foundation

class SquadViewModel {
    
    public var delegate: SquadDelegate?
    
    public var developers = [Developers](){
        didSet{
            DispatchQueue.main.async {
                self.delegate?.updateTableView()
            }
        }
    }
    
    public func fetchDevelopers() {
        developers = devs
    }
}
