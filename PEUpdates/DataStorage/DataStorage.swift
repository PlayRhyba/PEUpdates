//
//  DataStorage.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/15/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData
import CocoaLumberjack


class DataStorage: NSObject {
    
    typealias OperationCompletionBlock = (Bool, Error?) -> Void
    typealias FetchCompletionBlock = ([NSManagedObject]?, Error?) -> Void
    
    
    static let sharedInstance = DataStorage()
    let persistentContainer: NSPersistentContainer
    
    
    //MARK: NSObject
    
    
    private override init() {
        persistentContainer = NSPersistentContainer(name: Constants.Configuration.DataModelName)
    }
    
    
    //MARK: Public Methods
    
    
    func setup(withCompletion completion: OperationCompletionBlock?) {
        persistentContainer.loadPersistentStores { (_, error) in
            if error == nil {
                completion?(true, nil)
            }
            else {
                completion?(false, error)
            }
        }
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            DDLogInfo("\(type(of: self)): DOCUMENTS DIRECTORY PATH: \(Constants.LocalPaths.DocumentsDirectory)")
        #endif
    }
    
    
    func saveViewContext() throws {
        if persistentContainer.viewContext.hasChanges {
            try persistentContainer.viewContext.save()
        }
    }
}
