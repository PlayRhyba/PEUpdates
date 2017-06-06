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
    
    class func performAsynchroniuosFetch(requestConfiguration:(((NSFetchRequest<NSManagedObject>) -> Void)?),
                                         inContext context: NSManagedObjectContext,
                                         completionHandler: @escaping ((OperationResult<[NSManagedObject]>) -> Void)) {
        let fetchRequest = self.fetchRequest() as! NSFetchRequest<NSManagedObject>
        
        requestConfiguration?(fetchRequest)
        
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
            DispatchQueue.main.async {
                if let error = result.operationError {
                    completionHandler(OperationResult.failure(error))
                }
                else {
                    completionHandler(OperationResult.success(result.finalResult!))
                }
            }
        }
        
        _ = try? context.execute(asyncFetchRequest)
    }
    
    
    class func performFetch(requestConfiguration: (((NSFetchRequest<NSManagedObject>) -> Void)?),
                            inContext context: NSManagedObjectContext) -> [NSManagedObject]? {
        let fetchRequest = self.fetchRequest() as! NSFetchRequest<NSManagedObject>
        
        requestConfiguration?(fetchRequest)
        
        do {
            let objects = try context.fetch(fetchRequest)
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
