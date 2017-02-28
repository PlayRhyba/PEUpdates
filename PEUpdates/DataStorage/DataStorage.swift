//
//  DataStorage.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/15/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation
import MagicalRecord


class DataStorage: NSObject {
    
    typealias SaveCompletionBlock = (Bool, Error?) -> Void
    typealias FetchCompletionBlock = ([NSManagedObject]?, Error?) -> Void
    
    
    static let sharedInstance = DataStorage()
    
    
    //MARK: NSObject
    
    
    private override init() {}
    
    
    //MARK: Public Methods
    
    
    func setup() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: Constants.Configuration.DataModelName)
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            DDLogInfo("\(type(of: self)): DOCUMENTS DIRECTORY PATH: \(Constants.LocalPaths.DocumentsDirectory)")
        #endif
    }
    
    
    func cleanUp() {
        MagicalRecord.cleanUp()
    }
    
    
    func save(completion: SaveCompletionBlock?) {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: completion)
    }
}
