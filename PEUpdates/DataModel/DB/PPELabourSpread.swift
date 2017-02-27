//
//  PPELabourSpread.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-02-16.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class PPELabourSpread: PPEBaseDBDataModel {
    
    @NSManaged public var labourSpreadUUID: String?
    @NSManaged public var spreadID: NSNumber?
    @NSManaged public var fullName: String?
    @NSManaged public var title: String?
    @NSManaged public var p_description: String?
    @NSManaged public var note: String?
    
    
    //MARK: PPEBaseDBDataModel
    
    
    override func fill(withDictionary dictionary: [String: Any]?) {
        super.fill(withDictionary: dictionary)
        
        if let d = dictionary {
            autoreleasepool {
                labourSpreadUUID = value(fromDictionary: d, propertyName: #keyPath(labourSpreadUUID)) as? String
                spreadID = value(fromDictionary: d, propertyName: #keyPath(spreadID)) as? NSNumber
                fullName = value(fromDictionary: d, propertyName: #keyPath(fullName)) as? String
                title = value(fromDictionary: d, propertyName: #keyPath(title)) as? String
                p_description = value(fromDictionary: d, propertyName: #keyPath(p_description)) as? String
                note = value(fromDictionary: d, propertyName: #keyPath(note)) as? String
            }
        }
    }
    
    
    //MARK: PPEDataModel
    
    
    override var tableName: String {
        return Constants.Tables.LabourSpread
    }
}
