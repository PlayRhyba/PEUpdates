//
//  FieldDescription.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class FieldDescription: BaseMemoryDataModel {
    
    var type: String?
    var name: String?
    var tableName: String?
    
    
    //MARK: BaseMemoryDataModel
    
    
    override init(withDictionary dictionary: [String: Any]?) {
        super.init(withDictionary: dictionary)
        
        type = dictionary?["type"] as? String
        name = dictionary?["name"] as? String ?? type
        tableName = dictionary?["tableName"] as? String
    }
}
