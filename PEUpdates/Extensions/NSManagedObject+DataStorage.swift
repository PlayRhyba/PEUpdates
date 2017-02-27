//
//  NSManagedObject+AsynchroniousFetch.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-27.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import MagicalRecord


extension (NSManagedObject) {
    
    class func performAsynchroniuosFetch(withRequestConfiguration configuration:(((NSFetchRequest<NSManagedObject>) -> Void)?),
                                         completion: PPEDataStorage.FetchCompletionBlock?) {
        var fetchRequest: NSFetchRequest<NSManagedObject>!
        
        if #available(iOS 10.0, *) {
            fetchRequest = self.fetchRequest() as! NSFetchRequest<NSManagedObject>
        } else {
            fetchRequest = NSFetchRequest(entityName: self.className)
        }
        
        configuration?(fetchRequest)
        
        let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { (result) in
            if let block = completion {
                DispatchQueue.main.async {
                    block(result.finalResult, result.operationError)
                }
            }
        }
        
        _ = try? NSManagedObjectContext.mr_default().execute(asyncFetchRequest)
    }
}
