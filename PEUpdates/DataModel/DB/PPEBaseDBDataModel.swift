//
//  BaseDataModel.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-01-31.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData
import CocoaLumberjack


@objc class PPEBaseDBDataModel: NSManagedObject, PPEDataModel {
    
    @NSManaged public var created: NSNumber?
    @NSManaged public var modified: NSNumber?
    @NSManaged public var p_deleted: NSNumber?
    
    
    //MARK: Public Methods
    
    
    func fill(withDictionary dictionary: [String: Any]?) {
        autoreleasepool {
            guard let d = dictionary else { return }
            
            let baseModelSubclass = self.superclass === PPEBaseDBDataModel.self
            let propertiesInfo = self.propertiesInfo(includeSuperclass: baseModelSubclass)
            
            for (name, type) in propertiesInfo {
                let configurationManager = PPEConfigurationManager.sharedInstance
                var fieldDescription = configurationManager.fieldDesctiption(name: name, table: self.tableName)
                
                if fieldDescription == nil && baseModelSubclass {
                    fieldDescription = configurationManager.fieldDesctiption(name: name, table: Constants.Tables.Base)
                }
                
                if let fd = fieldDescription {
                    var value: Any? = d[fd.type!]
                    
                    if value is NSNull {
                        value = nil;
                    }
                    else if type is NSDate.Type {
                        if value is String {
                            value = Constants.DateFormats.date(fromString:value as! String)
                        }
                    }
                    
                    self.setValue(value, forKey: name)
                }
            }
        }
    }
    
    
    //MARK: PPEDataModel
    
    
    var tableName: String {
        return Constants.Tables.Base
    }
    
    
    func postDictionary() -> [String: Any] {
        return Dictionary()
    }
}
