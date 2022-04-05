//
//  ManagerObjectContext.swift
//  final-project
//
//  Created by Idwall Go Dev 001 on 31/03/22.
//

import Foundation
import UIKit
import CoreData

enum DataResult {
    case Success
    case Error(String)
}

typealias onCompletion = (DataResult) -> Void

protocol managedProtocol {
    func save(item: Repository, onCompletion: onCompletion)
}

protocol managedDeleteProtocol {
    func delete(id: Int, onCompletion: onCompletion)
}

protocol managedListProtocol {
    func list(onCompletion: onCompletion) -> [Repository]
}

class ManagedObjectContext {
    private let entity = "Favorited_"
    
    static var shared: ManagedObjectContext = {
        let instance = ManagedObjectContext()
        
        return instance
    }()
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveData(_ item: Repository) throws {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: context) else { return }
        
        let transaction = NSManagedObject(entity: entity, insertInto: context)
        
        // inserir dados
        transaction.setValue(item.id, forKey: "id")
        transaction.setValue(item.name, forKey: "name")
        transaction.setValue(item.description, forKey: "description_")
        transaction.setValue(item.avatarURL, forKey: "avatarURL")
        transaction.setValue(item.createdAt, forKey: "createdAt")
        transaction.setValue(item.watchersCount, forKey: "watchersCount")
        transaction.setValue(item.login, forKey: "login")
        transaction.setValue(item.url, forKey: "url")
        transaction.setValue(item.license, forKey: "license")
        transaction.setValue(item.authorName, forKey: "authorName")
        
        try context.save()
        
    }
}

extension ManagedObjectContext: managedProtocol {
    func save(item: Repository, onCompletion: (DataResult) -> Void) {
        do  {
            try saveData(item)
            onCompletion(.Success)
        } catch {
            onCompletion(.Error("Erro ao salvar dados"))
        }
    }

}

extension ManagedObjectContext: managedListProtocol {
    func list(onCompletion: (DataResult) -> Void) -> [Repository] {
        var itemList: [Repository] = []
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        
        do {
            
            guard let items = try getContext().fetch(fetchRequest) as? [NSManagedObject] else {return itemList}
            
            for item in items {
                if let id = item.value(forKey: "id") as? Int,
                    let name = item.value(forKey: "name") as? String,
                    let description = item.value(forKey: "description_") as? String,
                    let avatarURL = item.value(forKey: "avatarURL") as? String,
                    let createdAt = item.value(forKey: "createdAt") as? String,
                    let watchersCount = item.value(forKey: "watchersCount") as? Int,
                    let login = item.value(forKey: "login") as? String,
                    let url = item.value(forKey: "url") as? String,
                   let license = item.value(forKey: "license") as? String,
                    let authorName = item.value(forKey: "authorName") as? String
                {
                    
                    let favorited: Repository = Repository(id: id, name: name, description: description, avatarURL: avatarURL, createdAt: createdAt, watchersCount: watchersCount, login: login, url: url, license: license, authorName: authorName)
                    
                  itemList.append(favorited)
                    
                }
            }
            
        } catch let error as NSError {
            onCompletion(.Error(error.localizedDescription))
        }
        
        return itemList
    }
}


extension ManagedObjectContext: managedDeleteProtocol {
    func delete(id: Int, onCompletion: (DataResult) -> Void) {
        let context = getContext()
        
        let predicate = NSPredicate(format: "id == %d", id)
        
        let fetRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        
        fetRequest.predicate = predicate
        
        do {
            
            let fetchResults = try context.fetch(fetRequest) as! [NSManagedObject]
            
            if let entityToDelete = fetchResults.first {
                context.delete(entityToDelete)
            }
            
            try context.save()
            
            onCompletion(.Success)
            
        } catch let error as NSError {
            onCompletion(.Error(error.localizedDescription))
        }
    }
}
