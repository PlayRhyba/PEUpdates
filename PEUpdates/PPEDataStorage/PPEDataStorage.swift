//
//  PPEDataStorage.swift
//  PEUpdates
//
//  Created by Alexander Snegursky on 1/15/17.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import UIKit
import MagicalRecord


class PPEDataStorage: NSObject {
    
    static let sharedInstance = PPEDataStorage()
    
    
    //MARK: NSObject
    
    
    private override init() {}
    
    
    //MARK: Public Methods
    
    
    func setup () {
        MagicalRecord.setupCoreDataStack(withStoreNamed: Constants.Configuration.DataModelName)
        
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            DDLogInfo(String(format: "%@: DOCUMENTS DIRECTORY PATH: %@",
                             String(describing: self),
                             Constants.LocalPaths.DocumentsDirectory))
        #endif
    }
    
    
    func cleanUp () {
        MagicalRecord.cleanUp()
    }
}
