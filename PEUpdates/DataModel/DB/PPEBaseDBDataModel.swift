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
    
    
    func fill(withDictionary dictionary: Dictionary<String, Any>?) {
        guard let d = dictionary else { return }
        
        let propertiesInfo = self.propertiesInfo()
        
        for (name, type) in propertiesInfo {
            let fieldDescription = PPEConfigurationManager.sharedInstance.fieldDesctiption(name: name,
                                                                                           table: tableName)
            if let fd = fieldDescription {
                var value = d[fd.type!]
                
                if "\(type)".contains("Bool")  {
                    value = (value as? NSNumber)?.boolValue ?? false
                }
                
                self.setValue(value, forKey: name)
                
                DDLogInfo(String(format: "%@: SETTING PROPERTY: %@ TYPE: %@ VALUE: %@",
                                 "\(self.classForCoder)", name, "\(type)", "\(value)"))
            }
        }
    }
    
    
    //MARK: PPEDataModel
    
    
    var tableName: String {
        return ""
    }
    
    
    func postDictionary() -> Dictionary<String, Any> {
        return Dictionary()
    }
}
