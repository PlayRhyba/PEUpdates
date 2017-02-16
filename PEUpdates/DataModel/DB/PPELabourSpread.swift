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
    
    
    //MARK: PPEDataModel
    
    
    override var tableName: String {
        return Constants.Tables.LabourSpread
    }
}
