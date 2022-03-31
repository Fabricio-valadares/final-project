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
    func save(item: Item, onCompletion: onCompletion)
}

protocol managedDeleteProtocol {
    func delete(id: Int, onCompletion: onCompletion)
}

protocol managedListProtocol {
    func list(onCompletion: onCompletion) -> [Item]
}


class ManagedObjectContext {
    private let entity = "Item_"
    
    static var shared: ManagedObjectContext = {
        let instance = ManagedObjectContext()
        
        return instance
    }()
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        
        return appDelegate.persistentContainer.viewContext
    }
    
    func saveData(_ item: Item) throws {
        let context = getContext()
        
        guard let entity = NSEntityDescription.entity(forEntityName: entity, in: context) else { return }
        
        let transaction = NSManagedObject(entity: entity, insertInto: context)
        
        // inserir dados
        transaction.setValue(UUID(), forKey: "uuid")
        transaction.setValue(item.id, forKey: "id")
        
        try context.save()
        
    }
}

extension ManagedObjectContext: managedProtocol {
    func save(item: Item, onCompletion: (DataResult) -> Void) {
        do  {
            try saveData(item)
        } catch {
            onCompletion(.Error("Erro ao salvar dados"))
        }
    }

}

extension ManagedObjectContext: managedListProtocol {
    func list(onCompletion: (DataResult) -> Void) -> [Item] {
        var itemList: [Item] = []
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity)
        
        do {
            
            guard let items = try getContext().fetch(fetchRequest) as? [NSManagedObject] else {return itemList}
            
            for item in items {
                if let id = item.value(forKey: "id") as? Int
                {
                    
                    print(id)
                  //  let itemObject: Item = Item(id: id, )
                    
                  // itemList.append(itemObject)
                    
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
        
        let predicate = NSPredicate(format: "id == %@", "\(id)")
        
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
