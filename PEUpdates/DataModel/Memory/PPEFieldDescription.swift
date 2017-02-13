//
//  PPEFieldDescription.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class PPEFieldDescription: PPEBaseMemoryDataModel {
    
    var type: String?
    var name: String?
    var tableName: String?
    
    
    override init(withDictionary dictionary: Dictionary<String, Any>?) {
        super.init(withDictionary: dictionary)
        
        type = dictionary?["type"] as? String
        name = dictionary?["name"] as? String ?? type
        tableName = dictionary?["tableName"] as? String
    }
}
