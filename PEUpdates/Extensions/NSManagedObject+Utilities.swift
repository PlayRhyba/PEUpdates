//
//  NSManagedObject+AsynchroniousFetch.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-27.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData
import CocoaLumberjack


extension NSManagedObject {
    
    class func performAsynchroniuosFetch(withRequestConfiguration configuration:(((NSFetchRequest<NSManagedObject>) -> Void)?),
                                         inContext context: NSManagedObjectContext,
                                         completion: @escaping DataStorage.FetchCompletionBlock) {
        let fetchRequest = self.fetchRequest() as! NSFetchRequest<NSManagedObject>
        
        configuration?(fetchRequest)
        
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result) in
            DispatchQueue.main.async {
                completion(result.finalResult, result.operationError)
            }
        }
        
        _ = try? context.execute(asyncFetchRequest)
    }
    
    
    class func performFetch(withRequestConfiguration configuration: (((NSFetchRequest<NSManagedObject>) -> Void)?),
                            inContext context: NSManagedObjectContext) -> [NSManagedObject]? {
        do {
            let objects = try context.fetch(self.fetchRequest()) as! [NSManagedObject]
            return objects
        }
        catch {
            DDLogInfo("\(type(of: self)): CAN'T FETCH OBJECTS. ERROR: \(error)")
            return nil
        }
    }
    
    
    class func deleteAll(inContext context: NSManagedObjectContext) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: self.fetchRequest())
        
        do {
            try context.persistentStoreCoordinator?.execute(deleteRequest, with: context)
        }
        catch {
            DDLogInfo("\(type(of: self)): CAN'T DELETE OBJECTS. ERROR: \(error)")
        }
    }
}
