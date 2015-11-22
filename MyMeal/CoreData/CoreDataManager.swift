//
//  CoreDataManager.swift
//  Tourist
//
//  Created by Алексей Шпирко on 10/09/15.
//  Copyright (c) 2015 AlexShpirko LLC. All rights reserved.
//

import Foundation
import CoreData


class CoreDataManager {
    
    static let sharedInstance = CoreDataManager()
    
    
    func save() {
        
        if (!self.mainContex!.hasChanges) {
            return
        }
        
        CoreDataManager.sharedInstance.mainContex?.performBlockAndWait( {
            
            do {
                try CoreDataManager.sharedInstance.mainContex?.save()
            } catch {
                print("Unresolved error in saving main context\(error)")

            }
            
        })
    }
    
    
    func entity<T:NSManagedObject>(entityId:String, force:Bool) -> T? {
        
        let entityName = NSStringFromClass(T)
        let entity = NSEntityDescription.entityForName(entityName, inManagedObjectContext: self.mainContex!)
        let request = NSFetchRequest()
        request.entity = entity
        request.predicate = NSPredicate(format: "recipeId = %@", entityId)
        var result:[AnyObject]?
       
        do {
            try result = self.mainContex!.executeFetchRequest(request)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        if (result?.count == 0 && force) {
            
           let _entity = NSEntityDescription.insertNewObjectForEntityForName(entityName, inManagedObjectContext: self.mainContex!) as! T
            return _entity
        }
        
        return result?.last as? T
    }
    
    func removeEntity(entity:NSManagedObject) {
        
        self.mainContex!.deleteObject(entity)
    }
    
    
    //main context - all operations ui main thread
    lazy var mainContex: NSManagedObjectContext? = {
        
          var context = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
          context.persistentStoreCoordinator = self.storeCoordinator
          return context
        
    }()
   
    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.storeCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
        }()
    
    //managed model
    lazy var managedModel: NSManagedObjectModel = {
    
        let path = NSBundle.mainBundle().pathForResource("MyMeal", ofType:"momd")
        let momdUrl = NSURL.fileURLWithPath(path!)
        var localModel = NSManagedObjectModel(contentsOfURL: momdUrl)
        return localModel!
    }()
    
    //Store coordinator
    lazy var storeCoordinator: NSPersistentStoreCoordinator? = {
        
        let storeURL = self.applicationDocumentsDirectory.URLByAppendingPathComponent("MyMeal.sqlite")
        
        var coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel:self.managedModel)
            
        func addStore() {
            
            do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeURL, options: nil)
            } catch {
                print("Create persistent store error occurred")

            }
        }
        addStore()
    
        return coordinator
    }()
    
    // Returns the URL to the application's Documents directory.
    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.shpirko.alex.Tourist" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] 
    }()
}
