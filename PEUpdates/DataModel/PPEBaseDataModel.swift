//
//  BaseDataModel.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-01-31.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class PPEBaseDataModel: NSManagedObject {
    
    func fill(withDictionary dictionary: Dictionary<String, Any>?) {}
    
    func postDictionary() -> Dictionary<String, Any> {
        return Dictionary()
    }
}
