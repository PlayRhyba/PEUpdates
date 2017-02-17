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
    
    
    //MARK: Public Methods
    
    
    func fill(withDictionary dictionary: [String: Any]?) {
        guard let d = dictionary else { return }
        
        let propertiesInfo = self.propertiesInfo()
        
        for (name, type) in propertiesInfo {
            let fieldDescription = PPEConfigurationManager.sharedInstance.fieldDesctiption(name: name,
                                                                                           table: tableName)
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
                
                DDLogDebug(String(format: "%@: SETTING PROPERTY: %@ TYPE: %@ VALUE: %@",
                                  "\(classForCoder)", name, "\(type)", "\(value)"))
            }
        }
    }
    
    
    //MARK: PPEDataModel
    
    
    var tableName: String {
        return ""
    }
    
    
    func postDictionary() -> [String: Any] {
        return Dictionary()
    }
}
