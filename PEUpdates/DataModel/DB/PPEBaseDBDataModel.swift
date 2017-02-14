//
//  BaseDataModel.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-01-31.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class PPEBaseDBDataModel: NSManagedObject, PPEDataModel {
    
    
    //MARK: Public Methods
    
    
    func fill(withDictionary dictionary: Dictionary<String, Any>?) {
        guard let d = dictionary else { return }
        
        let propertiesInfo = self.propertiesInfo()
        
        for (name, type) in propertiesInfo {
            print("‘\(name)’ is ‘\(type)’") //!!!
            
            let fieldDescription = PPEConfigurationManager.sharedInstance.fieldDesctiption(name: name,
                                                                                           table: tableName)
            if let fd = fieldDescription {
                var value = d[fd.type!]
                
                if (type is Bool) {
                    value = (value as? NSNumber)?.boolValue ?? false
                }
                
                self.setValue(value, forKey: name)
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
