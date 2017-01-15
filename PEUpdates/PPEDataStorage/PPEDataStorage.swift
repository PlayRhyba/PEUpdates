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
    
    
    private override init() {
        MagicalRecord.setupCoreDataStack(withStoreNamed: Constants.Configuration.DataModelName)
    }
    
    
    deinit {
        MagicalRecord.cleanUp()
    }
}
