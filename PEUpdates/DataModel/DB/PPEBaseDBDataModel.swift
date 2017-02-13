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
    
    
    func fill(withDictionary dictionary: Dictionary<String, Any>?) {}
    
    
    //MARK: PPEDataModel
    
    
    var tableName: String {
        return ""
    }
    
    
    func postDictionary() -> Dictionary<String, Any> {
        return Dictionary()
    }
}
