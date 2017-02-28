//
//  FieldDescription.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-13.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import Foundation


class FieldDescription: BaseMemoryDataModel {
    
    var type: String!
    var propertyName: String!
    var name: String!
    var tableName: String?
    
    
    //MARK: BaseMemoryDataModel
    
    
    override init(withDictionary dictionary: [String: Any]?) {
        super.init(withDictionary: dictionary)
        
        if let d = dictionary {
            type = d[(#keyPath(type))] as! String
            propertyName = d[(#keyPath(propertyName))] as? String ?? type
            name = d[(#keyPath(name))] as? String ?? type
            tableName = d[(#keyPath(tableName))] as? String
        }
    }
}
