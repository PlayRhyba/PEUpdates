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
    
    enum ValueProcessingMode {
        case Default
        case Date
    }
    
    
    @NSManaged public var created: NSNumber?
    @NSManaged public var modified: NSNumber?
    @NSManaged public var p_deleted: NSNumber?
    
    
    //MARK: Public Methods
    
    
    func fill(withDictionary dictionary: [String: Any]?) {
        if let d = dictionary {
            created = value(fromDictionary: d, propertyName: #keyPath(created)) as? NSNumber
            modified = value(fromDictionary: d, propertyName: #keyPath(modified)) as? NSNumber
            p_deleted = value(fromDictionary: d, propertyName: #keyPath(p_deleted)) as? NSNumber
        }
    }
    
    
    func value(fromDictionary dictionary: [String: Any]?, propertyName: String, processingMode: ValueProcessingMode = .Default) -> Any? {
        guard let d = dictionary, let fd = fieldDescription(propertyName: propertyName) else {
            return nil
        }
        
        return process(value: d[fd.type!], mode: processingMode)
    }
    
    
    //MARK: PPEDataModel
    
    
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
    
    
    private func fieldDescription(propertyName: String) -> PPEFieldDescription? {
        let configurationManager = PPEConfigurationManager.sharedInstance
        return configurationManager.fieldDesctiption(name: propertyName, table: tableName)
    }
}
