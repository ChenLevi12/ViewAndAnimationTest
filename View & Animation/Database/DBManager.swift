//
//  DBManager.swift
//  View & Animation
//
//  Created by chen levi on 14.5.2018.
//  Copyright © 2018 chen levi. All rights reserved.
//

import UIKit
import CoreData

fileprivate let instance = DBManager()


class DBManager: NSObject {
    public class var shared : DBManager{
        return instance
    }

    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "View___Animation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
  
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
              
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    public var context : NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    public func getCharacters() throws -> [Character]{
        return try context.fetch(Character.fetchRequest())
    }
    
    
}
