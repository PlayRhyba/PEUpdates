//
//  BaseDBDataModel.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-01-31.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData
import CocoaLumberjack


@objc class BaseDBDataModel: NSManagedObject, DataModel {
    
    enum ValueProcessingMode {
        case Default
        case Date
    }
    
    
    @NSManaged public var created: NSNumber?
    @NSManaged public var modified: NSNumber?
    @NSManaged public var objectDeleted: NSNumber?
    
    
    //MARK: Public Methods
    
    
    func fill(withDictionary dictionary: [String: Any]?) {
        if let d = dictionary {
            autoreleasepool {
                created = value(fromDictionary: d, propertyName: #keyPath(created)) as? NSNumber
                modified = value(fromDictionary: d, propertyName: #keyPath(modified)) as? NSNumber
                objectDeleted = value(fromDictionary: d, propertyName: #keyPath(objectDeleted)) as? NSNumber
            }
        }
    }
    
    
    func value(fromDictionary dictionary: [String: Any]?, propertyName: String, processingMode: ValueProcessingMode = .Default) -> Any? {
        guard let d = dictionary, let fd = fieldDescription(propertyName: propertyName) else {
            return nil
        }
        
        return process(value: d[fd.type!], mode: processingMode)
    }
    
    
    //MARK: DataModel
    
    
    var tableName: String {
        return Constants.Tables.Base
    }
    
    
    func postDictionary() -> [String: Any] {
        return Dictionary()
    }
    
    
    //MARK: Internal Logic
    
    
    private func process(value: Any?, mode: ValueProcessingMode) -> Any? {
        if value == nil || value is NSNull {
            return nil
        }
        
        switch mode {
        case .Date:
            if value is String {
                return Constants.DateFormats.date(fromString:value as! String)
            }
            
        case .Default: break
        }
        
        return value
    }
    
    
    private func fieldDescription(propertyName: String) -> FieldDescription? {
        let configurationManager = ConfigurationManager.sharedInstance
        var fd = configurationManager.fieldDesctiption(propertyName: propertyName, table: tableName)
        
        if fd == nil {
            fd = configurationManager.fieldDesctiption(propertyName: propertyName, table: Constants.Tables.Base)
        }
        
        if fd == nil {
            DDLogWarn("\(type(of: self)): FIELD FOR PROPERTY \(propertyName) NOT FOUND")
        }
        
        return fd
    }
}
