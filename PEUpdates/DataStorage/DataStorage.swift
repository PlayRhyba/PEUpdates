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
    
    static let shared = DataStorage()
    let persistentContainer: NSPersistentContainer
    
    
    //MARK: NSObject
    
    
    private override init() {
        persistentContainer = NSPersistentContainer(name: Constants.Configuration.DataModelName)
    }
    
    
    //MARK: Public Methods
    
    
    func setup(completionHaldler: ((OperationResult<Void>) -> Void)?) {
        persistentContainer.loadPersistentStores { (_, error) in
            if error == nil {
                completionHaldler?(OperationResult.success())
            }
            else {
                completionHaldler?(OperationResult.failure(error!))
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
    
    
    func clear() throws {
        let context = persistentContainer.viewContext
        
        clearJobsSpreadsData(inContext: context)
        clearWeldData(inContext: context)
        
        try saveViewContext()
    }
}
