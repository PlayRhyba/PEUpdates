//
//  Profile.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-01-31.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class PPEProfile: PPEBaseDBDataModel {
    
    @NSManaged public var companyID: String?
    @NSManaged public var lastJobUUID: String?
    @NSManaged public var lastSpreadUUID: String?
    @NSManaged public var lastWeldUUID: String?
    @NSManaged public var measurementSystem: String?
    @NSManaged public var name: String?
    @NSManaged public var readOnly: NSNumber?
    @NSManaged public var role: String?
    @NSManaged public var roles: String?
    @NSManaged public var signatureData: String?

    
    //MARK: PPEDataModel
    
    
    override var tableName: String {
        return Constants.Tables.Profile
    }
}
