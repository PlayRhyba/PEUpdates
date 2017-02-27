//
//  Profile.swift
//  PEUpdates
//
//  Created by Alexander Snigurskyi on 2017-01-31.
//  Copyright © 2017 Alexander Snegursky. All rights reserved.
//


import CoreData


@objc class Profile: BaseDBDataModel {
    
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
    
    
    //MARK: BaseDBDataModel
    
    
    override func fill(withDictionary dictionary: [String: Any]?) {
        super.fill(withDictionary: dictionary)
        
        if let d = dictionary {
            autoreleasepool {
                companyID = value(fromDictionary: d, propertyName: #keyPath(companyID)) as? String
                lastJobUUID = value(fromDictionary: d, propertyName: #keyPath(lastJobUUID)) as? String
                lastSpreadUUID = value(fromDictionary: d, propertyName: #keyPath(lastSpreadUUID)) as? String
                lastWeldUUID = value(fromDictionary: d, propertyName: #keyPath(lastWeldUUID)) as? String
                measurementSystem = value(fromDictionary: d, propertyName: #keyPath(measurementSystem)) as? String
                name = value(fromDictionary: d, propertyName: #keyPath(name)) as? String
                readOnly = value(fromDictionary: d, propertyName: #keyPath(readOnly)) as? NSNumber
                role = value(fromDictionary: d, propertyName: #keyPath(role)) as? String
                roles = value(fromDictionary: d, propertyName: #keyPath(roles)) as? String
                signatureData = value(fromDictionary: d, propertyName: #keyPath(signatureData)) as? String
            }
        }
    }
    
    
    //MARK: DataModel
    
    
    override var tableName: String {
        return Constants.Tables.Profile
    }
}
